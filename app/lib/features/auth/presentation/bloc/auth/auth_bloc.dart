import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/auth/domain/usecases/logout.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  authenticatedTrip,
  authenticatedDriver,
  unknown
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerifyAuthUseCase verifyAuthUseCase;
  final LogoutUseCase logoutUseCase;
  final storage = const FlutterSecureStorage();

  AuthBloc({
    required this.verifyAuthUseCase,
    required this.logoutUseCase,
  }) : super(const AuthState(AuthenticationStatus.unknown)) {
    on<CheckAuth>((event, emit) => checkAuth(event, emit));
    on<AuthLogoutEvent>((event, emit) => authLogoutEvent(event, emit));
    on<AuthLoginEvent>((event, emit) => authLoginEvent(event, emit));
  }

  checkAuth(event, emit) async {
    final failureOrCreateAccount = await verifyAuthUseCase({});

    emit(failureOrCreateAccount.fold(
        (failure) => const AuthState(AuthenticationStatus.unauthenticated),
        (authEntity) => AuthState(mapAuthType(authEntity))));
  }

  authLogoutEvent(event, Emitter emit) async {
    final failureOrLogout = await logoutUseCase(LogoutParams());
    emit(failureOrLogout.fold(
        (failure) => const AuthState(AuthenticationStatus.unauthenticated),
        (r) => const AuthState(AuthenticationStatus.unauthenticated)));
  }

  authLoginEvent(event, Emitter emit) async {
    final failureOrCreateAccount = await verifyAuthUseCase({});

    emit(failureOrCreateAccount.fold(
        (failure) => const AuthState(AuthenticationStatus.unauthenticated),
        (authEntity) => AuthState(mapAuthType(authEntity))));
  }
}
