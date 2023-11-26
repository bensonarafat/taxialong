import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/auth/domain/entities/auth_entity.dart';
import 'package:taxialong/features/auth/domain/entities/otp_entity.dart';
import 'package:taxialong/features/auth/domain/entities/telephone_entity.dart';
import 'package:taxialong/features/auth/domain/usecases/auth.dart';
import 'package:taxialong/features/auth/domain/usecases/create_account.dart';
import 'package:taxialong/features/auth/domain/usecases/telephone.dart';
import 'package:taxialong/features/auth/domain/usecases/logout.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountUserCase createAccountUserCase;
  final TelephoneUseCase telephoneUseCase;
  final VerifyOTPUserCase verifyOTPUserCase;
  final AuthUseCase authUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.createAccountUserCase,
    required this.telephoneUseCase,
    required this.verifyOTPUserCase,
    required this.logoutUseCase,
    required this.authUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((AuthEvent event, Emitter<AuthState> emit) async {
      if (event is CheckLoginEvent) {
      } else if (event is LogoutEvent) {
        emit(AuthLoadingState());
        final failureOrLogout = await logoutUseCase(LogoutParams());
        emit(failureOrLogout.fold(
            (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
            (r) => UnAuthenticatedState()));
      } else if (event is PhoneNumberEvent) {
        emit(AuthLoadingState());
        final failureOrPhoneNumberEvent = await telephoneUseCase(
          TelephoneParams(
            telephone: event.telephone,
          ),
        );

        emit(failureOrPhoneNumberEvent.fold(
            (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
            (telephoneEntity) =>
                PhoneNumberState(telephoneEntity: telephoneEntity)));
      } else if (event is VerifyOTPEvent) {
        emit(AuthLoadingState());
        // if its a new user
        if (event.handler == "new") {
          final failureOrVerifyOtp = await verifyOTPUserCase(VerifyOTPParams(
            otp: event.otp,
            telephone: event.telephone,
            uuid: event.uuid,
            handler: event.handler,
          ));
          emit(failureOrVerifyOtp.fold(
              (failure) =>
                  ErrorAuthState(message: _mapFailureToMessage(failure)),
              (otpEntity) => VerifyOTPState(otpEntity: otpEntity)));
        } else {
          final failureOrAuth = await authUseCase(AuthParams(
            otp: event.otp,
            telephone: event.telephone,
            uuid: event.uuid,
            handler: event.handler,
          ));
          emit(failureOrAuth.fold(
              (failure) =>
                  ErrorAuthState(message: _mapFailureToMessage(failure)),
              (authEntity) => LoginState(authEntity: authEntity)));
        }
      } else if (event is CreateAccountEvent) {
        emit(AuthLoadingState());
        final failureOrCreateAccount = await createAccountUserCase(
          CreateAccountParams(
            firstname: event.firstname,
            lastname: event.lastname,
            email: event.email,
            uuid: event.uuid,
            telephone: event.telephone,
          ),
        );
        emit(failureOrCreateAccount.fold(
            (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
            (authEntity) => CreateAccountState(authEntity: authEntity)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'There was a server error!';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network error, check your internet connection';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
