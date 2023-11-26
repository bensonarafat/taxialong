import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxialong/core/services/get_it_services.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';

class AuthStreamScope extends InheritedNotifier<GoRouterRefereshStream> {
  AuthStreamScope({super.key, required super.child})
      : super(notifier: GoRouterRefereshStream(getIt.get<AuthBloc>().stream));
  static GoRouterRefereshStream of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<AuthStreamScope>()!.notifier!;
}

class GoRouterRefereshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> subscription;
  GoRouterRefereshStream(Stream<dynamic> stream) {
    notifyListeners();
    subscription = stream.asBroadcastStream().listen(
          (event) => notifyListeners(),
        );
  }

  bool isSignedIn() => getIt.get<AuthBloc>().state != null;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
