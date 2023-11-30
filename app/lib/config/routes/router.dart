import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:taxialong/core/widgets/taxi_along_bottom_navigation.dart';
import 'package:taxialong/features/about/presentation/pages/about.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/pages/create_account.dart';
import 'package:taxialong/features/auth/presentation/pages/login.dart';
import 'package:taxialong/features/auth/presentation/pages/phone_number_verification.dart';
import 'package:taxialong/features/auth/presentation/pages/signup.dart';
import 'package:taxialong/features/bus_stops/domain/entities/axis_entity.dart';
import 'package:taxialong/features/bus_stops/presentation/pages/bus_stops.dart';
import 'package:taxialong/features/documents/presentation/pages/documents.dart';
import 'package:taxialong/features/driver/presentation/pages/become_driver.dart';
import 'package:taxialong/features/help_center/presentation/pages/help_center.dart';
import 'package:taxialong/features/notification/presentation/pages/notification.dart';
import 'package:taxialong/features/onboard/presentation/pages/get_started.dart';
import 'package:taxialong/features/onboard/presentation/pages/onboarding.dart';
import 'package:taxialong/features/profile/presentation/pages/profile.dart';
import 'package:taxialong/features/referral/presentation/pages/referral.dart';
import 'package:taxialong/features/settings/presentation/pages/settings.dart';
import 'package:taxialong/features/taxi_classes/presentation/pages/taxi_classes.dart';
import 'package:taxialong/features/trip_history/presentation/pages/trip_history.dart';

final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();
final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      name: "home",
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: "/getstarted",
      name: "getStarted",
      builder: (context, state) => const GetStarted(),
    ),
    GoRoute(
      path: "/login",
      name: "login",
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/sign-up',
      name: "signUp",
      builder: (context, state) => const SignUp(),
    ),
    // navigations
    GoRoute(
      path: '/nav',
      name: "nav",
      builder: (context, state) => BlocProvider<BottomNavigationBloc>.value(
        value: bottomNavigationBloc,
        child: const TaxiAlongBottomNavigation(),
      ),
    ),
    // navigations

    GoRoute(
      path: '/create-account',
      name: "createAccount",
      builder: (context, state) => CreateAccount(
        otp: state.extra as OTPEntity,
      ),
    ),
    GoRoute(
      path: '/verify-otp',
      name: 'verifyOTP',
      builder: (context, state) =>
          PhoneNumberVerification(otp: state.extra as TelephoneEntity),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: '/bus-stop',
      name: 'busStop',
      builder: (context, state) => BusStop(
        params: state.extra as Map<String, dynamic>,
      ),
    ),
    GoRoute(
      path: '/taxi-classes',
      name: 'taxiClasses',
      builder: (context, state) => TaxiClasses(
        busstops: state.extra as AxisEntity,
      ),
    ),

    GoRoute(
      path: "/ride-history",
      name: "rideHistory",
      builder: (context, state) => const TripHistory(),
    ),

    GoRoute(
      path: "/notification",
      name: "notification",
      builder: (context, state) => const TaxiAlongNotification(),
    ),
    GoRoute(
      path: "/referral",
      name: "referral",
      builder: (context, state) => const Referral(),
    ),

    GoRoute(
      path: "/documents",
      name: "documents",
      builder: (context, state) => const Documents(),
    ),

    GoRoute(
      path: "/become-driver",
      name: "becomeDriver",
      builder: (context, state) => const BecomeDriver(),
    ),

    GoRoute(
      path: "/help-center",
      name: "helpCenter",
      builder: (context, state) => const HelpCenter(),
    ),

    GoRoute(
      path: "/settings",
      name: "settings",
      builder: (context, state) => const Settings(),
    ),

    GoRoute(
      path: "/about",
      name: "about",
      builder: (context, state) => const AboutPage(),
    ),
  ],
  redirect: (context, state) async {
    // const storage = FlutterSecureStorage();
    // Future<bool> isLoggedIn() async {
    //   String? authToken = await storage.read(key: 'jwt');
    //   return authToken != null && authToken.isNotEmpty;
    // }

    // current route if AuthStream has new sign-in information.
    // final bool loggedIn = AuthStreamScope.of(context).isSignedIn();
    // final bool loggingIn = state.matchedLocation == '/login' ||
    //     state.matchedLocation == 'getstarted';

    // bool token = await isLoggedIn();
    // print(">>> $loggedIn >> $loggingIn >> $token");
    // if (!loggedIn) {
    //   return '/getstarted';
    // }

    // if the user is logged in but still on the login page, send them to
    // the home page
    // if (loggingIn) {
    //   return '/nav';
    // }

    return null; // no need to redirect
  },
);
