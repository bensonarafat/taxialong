import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/pages/taxi_along_enable_location_page.dart';
import 'package:taxialong/core/widgets/taxi_along_bottom_navigation.dart';
import 'package:taxialong/features/about/presentation/pages/about.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/auth/presentation/pages/create_account.dart';
import 'package:taxialong/features/auth/presentation/pages/login.dart';
import 'package:taxialong/features/auth/presentation/pages/phone_number_verification.dart';
import 'package:taxialong/features/auth/presentation/pages/signup.dart';
import 'package:taxialong/features/bus_stops/presentation/pages/bus_stops.dart';
import 'package:taxialong/features/chat/presentation/pages/chat.dart';
import 'package:taxialong/features/documents/presentation/pages/documents.dart';
import 'package:taxialong/features/documents/presentation/pages/upload_documents.dart';
import 'package:taxialong/features/driver/presentation/pages/become_driver.dart';
import 'package:taxialong/features/driver/presentation/pages/home.dart';
import 'package:taxialong/features/help_center/presentation/pages/help_center.dart';
import 'package:taxialong/features/notification/presentation/pages/notification.dart';
import 'package:taxialong/features/onboard/presentation/pages/get_started.dart';
import 'package:taxialong/features/onboard/presentation/pages/onboarding.dart';
import 'package:taxialong/features/onboard/presentation/pages/splash.dart';
import 'package:taxialong/features/profile/presentation/pages/profile.dart';
import 'package:taxialong/features/rating/presentation/pages/rating.dart';
import 'package:taxialong/features/referral/presentation/pages/referral.dart';
import 'package:taxialong/features/trips/domain/entities/trip_entity.dart';
import 'package:taxialong/features/rides/presentation/pages/rides.dart';
import 'package:taxialong/features/settings/presentation/pages/settings.dart';
import 'package:taxialong/features/trip_history/presentation/pages/trip_history.dart';
import 'package:taxialong/features/trips/presentation/pages/cancel_trip.dart';
import 'package:taxialong/features/trips/presentation/pages/trip.dart';
import 'package:taxialong/features/vehicle/domain/entities/car_entity.dart';
import 'package:taxialong/features/vehicle/presentation/pages/car_seats_info.dart';
import 'package:taxialong/features/vehicle/presentation/pages/create_vehicle.dart';
import 'package:taxialong/features/vehicle/presentation/pages/edit_vehicle.dart';
import 'package:taxialong/features/vehicle/presentation/pages/vehicles.dart';
import 'package:taxialong/features/wallet/domain/entities/initialize_entity.dart';
import 'package:taxialong/features/wallet/presentation/pages/fund.dart';
import 'package:taxialong/features/wallet/presentation/pages/payment_webview.dart';
import 'package:taxialong/features/wallet/presentation/pages/transactions.dart';
import 'package:taxialong/features/wallet/presentation/pages/verify_payment.dart';
import 'package:taxialong/features/wallet/presentation/pages/wallet.dart';
import 'package:taxialong/features/wallet/presentation/pages/withdraw.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final BottomNavigationBloc bottomNavigationBloc =
      BottomNavigationBloc();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: "/splash",
      observers: [BotToastNavigatorObserver()],
      routes: [
        GoRoute(
          path: '/',
          name: "home",
          builder: (context, state) => const Onboarding(),
        ),
        GoRoute(
          path: '/splash',
          name: "splash",
          builder: (context, state) => const Splash(),
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
          path: '/wallet',
          name: 'wallet',
          builder: (context, state) => const Wallet(),
        ),
        GoRoute(
          path: '/bus-stop',
          name: 'busStop',
          builder: (context, state) => BusStop(
            params: state.extra as Map<String, dynamic>,
          ),
        ),
        GoRoute(
          path: '/rides',
          name: 'rides',
          builder: (context, state) => Rides(
            extra: state.extra as Map<String, dynamic>,
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

        GoRoute(
          path: "/upload-document",
          name: "uploadDocument",
          builder: (context, state) => const UploadDocuments(),
        ),
        GoRoute(
          path: "/driver-home",
          name: "driverHome",
          builder: (context, state) => const DriverHome(),
        ),
        GoRoute(
          path: "/enable-location",
          name: "enableLocation",
          builder: (context, state) => const TaxiAlongEnableLocationPage(),
        ),
        GoRoute(
          path: "/trip",
          name: "trip",
          builder: (context, state) => const Trip(),
        ),
        GoRoute(
          path: "/cancel-trip",
          name: "cancelTrip",
          builder: (context, state) => CancelTrip(
            trip: state.extra as TripEntity,
          ),
        ),
        GoRoute(
          path: "/withdraw-fund",
          name: "withdrawFund",
          builder: (context, state) => const Withdraw(),
        ),
        GoRoute(
          path: "/fund-wallet",
          name: "fundWallet",
          builder: (context, state) => const Fund(),
        ),

        GoRoute(
          path: "/payment-webview",
          name: "PaymentWebview",
          builder: (context, state) => PaymentWebView(
            initializeEntity: state.extra as InitializeEntity,
          ),
        ),

        GoRoute(
          path: "/verify-payment",
          name: "VerifyPayment",
          builder: (context, state) =>
              VerifyPayment(params: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: "/chat",
          name: "chat",
          builder: (context, state) => const Chat(),
        ),
        GoRoute(
          path: "/rating",
          name: "rating",
          builder: (context, state) => Rating(trip: state.extra as TripEntity),
        ),
        GoRoute(
          path: "/vehicles",
          name: "vehicles",
          builder: (context, state) => const Vehicles(),
        ),
        GoRoute(
          path: "/create-vehicle",
          name: "createVehicle",
          builder: (context, state) =>
              CreateVehicle(redirect: state.extra as String?),
        ),
        GoRoute(
          path: "/seat-info",
          name: "seatInfo",
          builder: (context, state) => const CarSeatsInfo(),
        ),
        GoRoute(
          path: "/edit-vehicle",
          name: "editVehicle",
          builder: (context, state) =>
              EditVehicle(car: state.extra as CarEntity),
        ),
        GoRoute(
          path: "/transactions",
          name: "transactions",
          builder: (context, state) => const Transactions(),
        ),
      ],
      redirect: (context, state) async {
        AuthenticationStatus status = context.read<AuthBloc>().state.status;
        bool unknown = status == AuthenticationStatus.unknown;
        bool isLogin = status == AuthenticationStatus.authenticated;
        bool isDriver = status == AuthenticationStatus.authenticatedDriver;
        bool isTrip = status == AuthenticationStatus.authenticatedTrip;

        if (unknown) {
          return '/splash';
        }
        if (isDriver && !allowedPages.contains(state.matchedLocation)) {
          return '/driver-home';
        }

        if (!isLogin &&
            isTrip &&
            !allowedPages.contains(state.matchedLocation)) {
          return '/trip';
        }

        if (isLogin && !allowedPages.contains(state.matchedLocation)) {
          return '/nav';
        }

        if (!isTrip && !isLogin && !authPages.contains(state.matchedLocation)) {
          if (!isDriver) {
            return '/';
          }
        }

        return null; // no need to redirect
      });

  static GoRouter get router => _router;
}
