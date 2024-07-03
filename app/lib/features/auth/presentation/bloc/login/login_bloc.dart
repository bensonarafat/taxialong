import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final storage = const FlutterSecureStorage();

  final CreateAccountUserCase createAccountUserCase;
  final TelephoneUseCase telephoneUseCase;
  final VerifyOTPUserCase verifyOTPUserCase;
  final AuthUseCase authUseCase;
  final LogoutUseCase logoutUseCase;

  LoginBloc({
    required this.createAccountUserCase,
    required this.telephoneUseCase,
    required this.verifyOTPUserCase,
    required this.logoutUseCase,
    required this.authUseCase,
  }) : super(LoginInitial()) {
    on<PhoneNumberEvent>((event, emit) => phoneNumberEvent(event, emit));
    on<VerifyOTPEvent>((event, emit) => verifyOTPEvent(event, emit));
    on<CreateAccountEvent>((event, emit) => createAccountEvent(event, emit));
  }

  createAccountEvent(event, emit) async {
    emit(LoginLoadingState());
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

  verifyOTPEvent(event, emit) async {
    emit(LoginLoadingState());
    // if its a new user
    if (event.handler == "new") {
      final failureOrVerifyOtp = await verifyOTPUserCase(VerifyOTPParams(
        otp: event.otp,
        telephone: event.telephone,
        uuid: event.uuid,
        handler: event.handler,
      ));
      emit(failureOrVerifyOtp.fold(
          (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
          (otpEntity) => VerifyOTPState(otpEntity: otpEntity)));
    } else {
      final failureOrAuth = await authUseCase(AuthParams(
        otp: event.otp,
        telephone: event.telephone,
        uuid: event.uuid,
        handler: event.handler,
      ));
      emit(failureOrAuth.fold(
          (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
          (authEntity) => UserLoginState(authEntity: authEntity)));
    }
  }

  phoneNumberEvent(event, emit) async {
    emit(LoginLoadingState());
    final failureOrPhoneNumberEvent = await telephoneUseCase(
      TelephoneParams(
        telephone: event.telephone,
      ),
    );

    emit(failureOrPhoneNumberEvent.fold(
        (failure) => ErrorAuthState(message: mapFailureToMessage(failure)),
        (telephoneEntity) =>
            PhoneNumberState(telephoneEntity: telephoneEntity)));
  }
}
