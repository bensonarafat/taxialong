import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taxialong/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taxialong/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';
import 'package:taxialong/features/auth/domain/usecases/auth.dart';
import 'package:taxialong/features/auth/domain/usecases/create_account.dart';
import 'package:taxialong/features/auth/domain/usecases/telephone.dart';
import 'package:taxialong/features/auth/domain/usecases/logout.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_otp.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      createAccountUserCase: getIt(),
      telephoneUseCase: getIt(),
      verifyOTPUserCase: getIt(),
      logoutUseCase: getIt(),
      authUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<TelephoneUseCase>(
      () => TelephoneUseCase(repository: getIt()));
  getIt.registerLazySingleton<CreateAccountUserCase>(
      () => CreateAccountUserCase(repository: getIt()));
  getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(repository: getIt()));
  getIt.registerLazySingleton<VerifyOTPUserCase>(
      () => VerifyOTPUserCase(repository: getIt()));
  getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: getIt()));

  // repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: getIt(),
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );

  //datasources
  final client = http.Client();
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            client: client,
            secureStorage: getIt(),
          ));

  // network
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //external
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  //storage
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
}
