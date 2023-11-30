import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:taxialong/features/bus_stops/data/datasources/bus_stop_remote_data_source.dart';
import 'package:taxialong/features/bus_stops/data/repositories/bus_stop_repository_impl.dart';
import 'package:taxialong/features/bus_stops/domain/repositories/bus_stop_repository.dart';
import 'package:taxialong/features/bus_stops/domain/usecases/get_bus_stop_usecase.dart';
import 'package:taxialong/features/bus_stops/presentation/bloc/busstop/bus_stop_bloc.dart';
import 'package:taxialong/features/home/data/datasources/home_local_data_source.dart';
import 'package:taxialong/features/home/data/datasources/home_remote_data_source.dart';
import 'package:taxialong/features/home/data/repositories/home_repository.dart';
import 'package:taxialong/features/home/domain/repositories/home_repository.dart';
import 'package:taxialong/features/home/domain/usecases/get_axis.dart';
import 'package:taxialong/features/home/domain/usecases/get_cache.dart';
import 'package:taxialong/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:taxialong/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:taxialong/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:taxialong/features/profile/domain/repositories/profile_repository.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:taxialong/features/profile/presentation/bloc/profile/profile_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
/**
 * -----------------------------------------------------------------------------------------------------------
 */

  //auth
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

/**
 * -----------------------------------------------------------------------------------------------------------
 */

  // home instance
  getIt.registerFactory<HomeBloc>(() => HomeBloc(
        axisUseCase: getIt(),
        axisCachedUseCase: getIt(),
      ));

  //usecase
  getIt.registerLazySingleton<GetAxisUseCase>(
      () => GetAxisUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetAxisCachedUseCase>(
      () => GetAxisCachedUseCase(repository: getIt()));
  //repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  //remote data source
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImp(client: client, secureStorage: getIt()),
  );

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

/**
 * -----------------------------------------------------------------------------------------------------------
 */
  // busstop instance
  getIt
      .registerFactory<BusStopBloc>(() => BusStopBloc(busStopUseCase: getIt()));

  //usecase
  getIt.registerLazySingleton<GetBusStopUseCase>(
      () => GetBusStopUseCase(repository: getIt()));

  //repository
  getIt.registerLazySingleton<BusStopRepository>(
    () => BusStopRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  //remote data source
  getIt.registerLazySingleton<BusStopRemoteDataSource>(
    () => BusStopRemoteDataSourceImpl(client: client, secureStorage: getIt()),
  );

  // Profile ------------------------------------------------------------------
  // profile instance
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
        updateProfileUseCase: getIt(),
        updateProfileImageUseCase: getIt(),
      ));
  //usecase
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(repository: getIt()));
  getIt.registerLazySingleton<UpdateProfileImageUseCase>(
      () => UpdateProfileImageUseCase(repository: getIt()));
  //repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );

  //remote data source
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: client, secureStorage: getIt()),
  );
}
