import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taxialong/core/utils/helpers.dart';
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
  final storage = const FlutterSecureStorage();

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
  }) : super(const AuthInitial()) {
    on<AuthEvent>((AuthEvent event, Emitter<AuthState> emit) async {
      if (event is CheckLoginEvent) {
        bool isLogin = await isLoggedIn();
        emit(AuthenticatedState(isLogin));
      } else if (event is LogoutEvent) {
        emit(const AuthLoadingState());
        final failureOrLogout = await logoutUseCase(LogoutParams());
        emit(failureOrLogout.fold(
            (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
            (r) => const AuthenticatedState(false)));
      } else if (event is PhoneNumberEvent) {
        emit(const AuthLoadingState());
        final failureOrPhoneNumberEvent = await telephoneUseCase(
          TelephoneParams(
            telephone: event.telephone,
          ),
        );

        emit(failureOrPhoneNumberEvent.fold(
            (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
            (telephoneEntity) =>
                PhoneNumberState(telephoneEntity: telephoneEntity)));
      } else if (event is VerifyOTPEvent) {
        emit(const AuthLoadingState());
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
                  ErrorAuthState(message: mapFailureToMessage(failure)),
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
                  ErrorAuthState(message: mapFailureToMessage(failure)),
              (authEntity) => LoginState(authEntity: authEntity)));
        }
      } else if (event is CreateAccountEvent) {
        emit(const AuthLoadingState());
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
            (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
            (authEntity) => CreateAccountState(authEntity: authEntity)));
      }
    });
  }

  Future<bool> isLoggedIn() async {
    String? authToken = await storage.read(key: 'jwt');
    return authToken != null && authToken.isNotEmpty;
  }
}
