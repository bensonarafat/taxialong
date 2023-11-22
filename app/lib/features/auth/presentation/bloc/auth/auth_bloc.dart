import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/login_entity.dart';
import 'package:taxialong/features/auth/domain/entities/logout_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/register_entity.dart';
import 'package:taxialong/features/auth/domain/usecases/create_account.dart';
import 'package:taxialong/features/auth/domain/usecases/login.dart';
import 'package:taxialong/features/auth/domain/usecases/logout.dart';
import 'package:taxialong/features/auth/domain/usecases/register.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final CreateAccountUserCase createAccountUserCase;
  final RegisterUseCase registerUseCase;
  final VerifyOTPUserCase verifyOTPUserCase;
  final LogoutUseCase logoutUseCase;

  Completer<void> completer = Completer<void>();

  AuthBloc({
    required this.createAccountUserCase,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyOTPUserCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckLoginEvent) {
      } else if (event is LogoutEvent) {
        emit(AuthLoadingState());
        final failureOrLogout = await logoutUseCase();
        emit(eitherToState(failureOrLogout, UnAuthenticatedState()));
      } else if (event is LoginEvent) {
        emit(AuthLoadingState());
        final failureOrUserCredential =
            await loginUseCase(params: event.loginEntity);
        emit(eitherToState(failureOrUserCredential, LoginState()));
      } else if (event is RegisterEvent) {
        final failureOrRegisterEvent =
            await registerUseCase(params: event.registerEntity);
        emit(eitherToState(failureOrRegisterEvent, RegisterState()));
      } else if (event is VerifyOTPEvent) {
        final failureOrVerifyOtp =
            await verifyOTPUserCase(params: event.otpEntity);
        emit(eitherToState(failureOrVerifyOtp, VerifyOTPState()));
      } else if (event is CreateAccountEvent) {
        final failureOrCreateAccount =
            await createAccountUserCase(params: event.loginEntity);
        emit(eitherToState(failureOrCreateAccount, CreateAccountState()));
      }
    });
  }

  AuthState eitherToState(Either either, AuthState state) {
    return either.fold(
      (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'There was a server error!';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
