import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/onboard/presentation/pages/onboarding.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const TaxiAlong());

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class TaxiAlong extends StatelessWidget {
  const TaxiAlong({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData.dark(),
          title: 'Taxi Along',
          debugShowCheckedModeBanner: false,
          home: const Onboarding(),
        );
      },
    );
  }
}
