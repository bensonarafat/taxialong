import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:taxialong/core/constants/routes.dart';
import 'package:taxialong/core/widgets/taxi_along_bottom_navigation.dart';
import 'package:taxialong/features/auth/presentation/pages/create_account.dart';
import 'package:taxialong/features/auth/presentation/pages/login.dart';
import 'package:taxialong/features/auth/presentation/pages/phone_number_verification.dart';
import 'package:taxialong/features/auth/presentation/pages/signup.dart';
import 'package:taxialong/features/onboard/presentation/pages/get_started.dart';
import 'package:taxialong/features/onboard/presentation/pages/onboarding.dart';
import 'package:taxialong/features/profile/presentation/pages/profile.dart';

final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();
final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: getStarted,
      builder: (context, state) => const GetStarted(),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: signUp,
      builder: (context, state) => const SignUp(),
    ),
    // navigations
    GoRoute(
      path: nav,
      builder: (context, state) => BlocProvider<BottomNavigationBloc>.value(
        value: bottomNavigationBloc,
        child: const TaxiAlongBottomNavigation(),
      ),
    ),
    // navigations

    GoRoute(
      path: createAccount,
      builder: (context, state) => const CreateAccount(),
    ),
    GoRoute(
      path: verifyOTP,
      builder: (context, state) => const PhoneNumberVerification(),
    ),
    GoRoute(
      path: profile,
      builder: (context, state) => const Profile(),
    ),
  ],
  redirect: (context, state) {
    // calling `of` method creates a dependency of AuthStreamScope. It will make go_router to reparse
    // current route if AuthStream has new sign-in information.
    // final bool loggedIn = AuthStreamScope.of(context).isSignedIn();

    // implement your redirection logic here

    return null; // no need to redirect
  },
);
