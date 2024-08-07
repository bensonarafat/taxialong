import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/config/routes/router.dart';
import 'package:taxialong/config/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/trips/presentation/bloc/trip_bloc.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';
import 'firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupLocator();

  runApp(const TaxiAlong());

  FlutterNativeSplash.remove();
}

class TaxiAlong extends StatelessWidget {
  const TaxiAlong({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(CheckAuth()),
        ),
        BlocProvider<SettingsBloc>(create: (_) => getIt<SettingsBloc>()),
        BlocProvider<MapBloc>(
          create: (_) => getIt<MapBloc>(),
        ),
        // websocket
        BlocProvider<PusherBloc>(
          create: (_) => getIt<PusherBloc>(),
        ),
        BlocProvider<CarBloc>(
          create: (_) => getIt<CarBloc>(),
        ),
        BlocProvider<TripBloc>(
          create: (_) => getIt<TripBloc>(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          AppRouter.router.refresh();
        },
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              title: 'Taxi Along',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              builder: BotToastInit(),
            );
          },
        ),
      ),
    );
  }
}
