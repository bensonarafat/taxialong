import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxialong/core/bloc/map/map_bloc.dart';
import 'package:taxialong/core/bloc/settings/settings_bloc.dart';
import 'package:taxialong/core/bloc/web_sockets/pusher/pusher_bloc.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/data/datasources/remote_user_data_source.dart';
import 'package:taxialong/core/data/datasources/setting_remote_datasource.dart';
import 'package:taxialong/core/data/repositories/settings_repository_impl.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/domain/usecases/get_seats_usecase.dart';
import 'package:taxialong/core/domain/usecases/switch_account_usecase.dart';
import 'package:taxialong/core/domain/usecases/update_settings_usecase.dart';
import 'package:taxialong/core/services/local_storage.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taxialong/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taxialong/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taxialong/features/auth/domain/repositories/auth_repository.dart';
import 'package:taxialong/features/auth/domain/usecases/auth.dart';
import 'package:taxialong/features/auth/domain/usecases/create_account.dart';
import 'package:taxialong/features/auth/domain/usecases/telephone.dart';
import 'package:taxialong/features/auth/domain/usecases/logout.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_auth.dart';
import 'package:taxialong/features/auth/domain/usecases/verify_otp.dart';
import 'package:taxialong/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:taxialong/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:taxialong/features/bus_stops/data/datasources/bus_stop_remote_data_source.dart';
import 'package:taxialong/features/bus_stops/data/repositories/bus_stop_repository_impl.dart';
import 'package:taxialong/features/bus_stops/domain/repositories/bus_stop_repository.dart';
import 'package:taxialong/features/bus_stops/domain/usecases/get_bus_stop_usecase.dart';
import 'package:taxialong/features/bus_stops/presentation/bloc/busstop/bus_stop_bloc.dart';
import 'package:taxialong/features/documents/data/datasources/document_remote_data_source.dart';
import 'package:taxialong/features/documents/data/repositories/document_repository_impl.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';
import 'package:taxialong/features/documents/domain/usecases/document_complete_usecase.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';
import 'package:taxialong/features/documents/domain/usecases/get_documents_usecase.dart';
import 'package:taxialong/features/documents/presentation/bloc/document_bloc.dart';
import 'package:taxialong/features/driver/data/datasources/driver_home_remote_datasource.dart';
import 'package:taxialong/features/driver/data/repositories/driver_home_repository_impl.dart';
import 'package:taxialong/features/driver/domain/repositories/driver_home_repository.dart';
import 'package:taxialong/features/driver/domain/usecases/get_driver_data_usecase.dart';
import 'package:taxialong/core/domain/usecases/get_terminals_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/get_recent_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/get_request_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/go_online_usecase.dart';
import 'package:taxialong/features/driver/domain/usecases/update_driver_location_usecase.dart';
import 'package:taxialong/features/driver/presentation/bloc/home/driver_home_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/location/location_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/online/online_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/recent/recent_bloc.dart';
import 'package:taxialong/features/driver/presentation/bloc/request/request_bloc.dart';
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
import 'package:taxialong/features/rides/data/datasources/ride_remote_data_sources.dart';
import 'package:taxialong/features/rides/data/repositories/rides_repository_impl.dart';
import 'package:taxialong/features/rides/domain/repositories/ride_repository.dart';
import 'package:taxialong/features/rides/domain/usecases/confirm_ride_usecase.dart';
import 'package:taxialong/features/rides/domain/usecases/get_rides_usecase.dart';
import 'package:taxialong/features/rides/presentation/bloc/ride_bloc.dart';
import 'package:taxialong/features/trips/data/datasources/trip_remote_data_source.dart';
import 'package:taxialong/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:taxialong/features/trips/domain/repositories/trip_repository.dart';
import 'package:taxialong/features/trips/domain/usecases/cancel_trip_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/get_trip_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/update_complete_usecase.dart';
import 'package:taxialong/features/trips/domain/usecases/update_pickup_usecase.dart';
import 'package:taxialong/features/trips/presentation/bloc/cancel_trip/cancel_bloc.dart';
import 'package:taxialong/features/trips/presentation/bloc/trip_bloc.dart';
import 'package:taxialong/features/vehicle/data/datasources/car_remote_data_source.dart';
import 'package:taxialong/features/vehicle/data/repositories/car_repository_impl.dart';
import 'package:taxialong/features/vehicle/domain/repositories/car_repository.dart';
import 'package:taxialong/features/vehicle/domain/usecases/create_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/delete_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/edit_car_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/fetch_vehicle_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/fetch_vehicles_usecase.dart';
import 'package:taxialong/features/vehicle/domain/usecases/update_default_usecase.dart';
import 'package:taxialong/features/vehicle/presentation/bloc/car_bloc.dart';
import 'package:taxialong/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:taxialong/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/get_wallet_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/initialize_transaction_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/update_payment_method_usecase.dart';
import 'package:taxialong/features/wallet/domain/usecases/verify_payment_usecase.dart';
import 'package:taxialong/features/wallet/presentation/bloc/wallet_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
/**
 * -----------------------------------------------------------------------------------------------------------
 */

  //auth

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      verifyAuthUseCase: getIt(),
      logoutUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<VerifyAuthUseCase>(
      () => VerifyAuthUseCase(repository: getIt()));

  //login
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
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
      userDataSource: getIt(),
    ),
  );

  //storage
  getIt.registerLazySingleton<Dio>(() => Dio());
  //datasources
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            dio: getIt(),
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
  //map instance
  getIt.registerFactory<MapBloc>(() => MapBloc());

  getIt.registerFactory<PusherBloc>(() => PusherBloc());
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
    () => HomeRemoteDataSourceImp(dio: getIt(), secureStorage: getIt()),
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
    () => BusStopRemoteDataSourceImpl(dio: getIt(), secureStorage: getIt()),
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
      userDataSource: getIt(),
    ),
  );

  //remote data source
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: getIt(), secureStorage: getIt()),
  );

  /**
 * -----------------------------------------------------------------------------------------------------------
 */
  // documents instance
  getIt.registerFactory<DocumentBloc>(() => DocumentBloc(
        documentUploadUseCase: getIt(),
        documentCompleteUsecase: getIt(),
        getDocumentsUseCase: getIt(),
      ));
  //usecase
  getIt.registerLazySingleton<DocumentUploadUseCase>(
      () => DocumentUploadUseCase(repository: getIt()));
  getIt.registerLazySingleton<DocumentCompleteUsecase>(
      () => DocumentCompleteUsecase(repository: getIt()));

  getIt.registerLazySingleton<GetDocumentsUseCase>(
      () => GetDocumentsUseCase(repository: getIt()));

  //repository
  getIt.registerLazySingleton<DocumentRepository>(
    () => DocumentRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      localStorage: getIt(),
      userDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );
  //remote data source
  getIt.registerLazySingleton<DocumentRemoteDataSource>(
    () => DocumentRemoteDataSourceImpl(dio: getIt(), secureStorage: getIt()),
  );

  //user data source
  getIt.registerLazySingleton<UserDataSource>(
    () => UserDataSource(dio: getIt(), secureStorage: getIt()),
  );

  //local storage
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

  /**
 * -----------------------------------------------------------------------------------------------------------
 */
  // settings instance
  getIt.registerFactory<SettingsBloc>(() => SettingsBloc(
        switchAccountUseCase: getIt(),
        getTermainalUseCase: getIt(),
        updateSettingsUseCase: getIt(),
        getSeatsUseCase: getIt(),
      ));

  //usecase
  getIt.registerLazySingleton<SwitchAccountUseCase>(
      () => SwitchAccountUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetTermainalUseCase>(
      () => GetTermainalUseCase(repository: getIt()));
  getIt.registerLazySingleton<UpdateSettingsUseCase>(
      () => UpdateSettingsUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetSeatsUseCase>(
      () => GetSeatsUseCase(repository: getIt()));

  //repository
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      userDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );
  //remote data source
  getIt.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImp(dio: getIt(), secureStorage: getIt()),
  );

  /**
 * -----------------------------------------------------------------------------------------------------------
 */
  // driver instance
  getIt.registerFactory<DriverHomeBloc>(() => DriverHomeBloc(
        getDriverDataUseCase: getIt(),
      ));
  getIt.registerFactory<LocationBloc>(
      () => LocationBloc(updateDriverLocationUseCase: getIt()));

  getIt.registerFactory<RecentBloc>(() => RecentBloc(
        getRecentUseCase: getIt(),
      ));

  getIt.registerFactory<RequestBloc>(() => RequestBloc(
        getRequestUseCase: getIt(),
      ));

  //online
  getIt.registerFactory<OnlineBloc>(() => OnlineBloc(goOnlineUseCase: getIt()));
  //usecase
  getIt.registerLazySingleton<GoOnlineUseCase>(
      () => GoOnlineUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetDriverDataUseCase>(
      () => GetDriverDataUseCase(repository: getIt()));

  getIt.registerLazySingleton<UpdateDriverLocationUseCase>(
      () => UpdateDriverLocationUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetRecentUseCase>(
      () => GetRecentUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetRequestUseCase>(
      () => GetRequestUseCase(repository: getIt()));

  //repository
  getIt.registerLazySingleton<DriverHomeRepository>(
    () => DriverHomeRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      userDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );
  //remote data source
  getIt.registerLazySingleton<DriverHomeRemoteDataSource>(
    () => DriverHomeRemoteDataSourceImpl(dio: getIt(), secureStorage: getIt()),
  );

  /**
 * -----------------------------------------------------------------------------------------------------------
 */
  // rides instance
  getIt.registerFactory<RideBloc>(() => RideBloc(
        getRidesUseCase: getIt(),
        confirmRideUseCase: getIt(),
      ));

  //usecase
  getIt.registerLazySingleton<GetRidesUseCase>(
      () => GetRidesUseCase(repository: getIt()));
  getIt.registerLazySingleton<ConfirmRideUseCase>(
      () => ConfirmRideUseCase(repository: getIt()));

  //repository
  getIt.registerLazySingleton<RideRepository>(
    () => RidesRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );
  //remote data source
  getIt.registerLazySingleton<RideRemoteDataSource>(
    () => RideRemoteDataSourceImpl(dio: getIt(), secureStorage: getIt()),
  );

  getIt.registerLazySingleton(() => Logger());

  /**
 * -----------------------------------------------------------------------------------------------------------
 */

  // wallet instance
  getIt.registerFactory<WalletBloc>(() => WalletBloc(
        getTransactionUseCase: getIt(),
        getWalletUseCase: getIt(),
        updatePaymentMethodUseCase: getIt(),
        initializePaymentUseCase: getIt(),
        verifyPaymentUseCase: getIt(),
      ));

  //usecase
  getIt.registerLazySingleton<GetWalletUseCase>(
      () => GetWalletUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetTransactionUseCase>(
      () => GetTransactionUseCase(repository: getIt()));
  getIt.registerLazySingleton<UpdatePaymentMethodUseCase>(
      () => UpdatePaymentMethodUseCase(repository: getIt()));
  getIt.registerLazySingleton<InitializePaymentUseCase>(
      () => InitializePaymentUseCase(repository: getIt()));
  getIt.registerLazySingleton<VerifyPaymentUseCase>(
      () => VerifyPaymentUseCase(repository: getIt()));
  //repository
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      userDataSource: getIt(),
      secureStorage: getIt(),
    ),
  );
  //remote data source
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(
      dio: getIt(),
      secureStorage: getIt(),
    ),
  );

  /**
 * -----------------------------------------------------------------------------------------------------------
 */

  // trip instance
  getIt.registerFactory<TripBloc>(
    () => TripBloc(
      getTripUseCase: getIt(),
      updateCompleteUseCase: getIt(),
      updatePickUpUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CancelBloc>(
    () => CancelBloc(
      cancelTripUseCase: getIt(),
    ),
  );

  //usecase
  getIt.registerLazySingleton<GetTripUseCase>(
    () => GetTripUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<CancelTripUseCase>(
    () => CancelTripUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<UpdateCompleteUseCase>(
    () => UpdateCompleteUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton<UpdatePickUpUseCase>(
    () => UpdatePickUpUseCase(
      repository: getIt(),
    ),
  );
  //repository
  getIt.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // remote data source
  getIt.registerLazySingleton<TripRemoteDataSource>(
    () => TripRemoteDataSourceImpl(
      secureStorage: getIt(),
      dio: getIt(),
    ),
  );

  /**
 * -----------------------------------------------------------------------------------------------------------
 */

  // car instance
  getIt.registerFactory<CarBloc>(
    () => CarBloc(
      createCarUsecase: getIt(),
      fetchVehiclesUseCase: getIt(),
      deleteCarUseCase: getIt(),
      editCarUseCase: getIt(),
      fetchVehicleUseCase: getIt(),
      updateDefaultCarUseCase: getIt(),
    ),
  );

  //usecase
  getIt.registerLazySingleton<UpdateDefaultCarUseCase>(
    () => UpdateDefaultCarUseCase(
      carRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchVehicleUseCase>(
    () => FetchVehicleUseCase(
      carRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<EditCarUseCase>(
    () => EditCarUseCase(
      carRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<DeleteCarUseCase>(
    () => DeleteCarUseCase(
      carRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<CreateCarUsecase>(
    () => CreateCarUsecase(
      carRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchVehiclesUseCase>(
    () => FetchVehiclesUseCase(
      carRepository: getIt(),
    ),
  );
  //repository
  getIt.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // remote data source
  getIt.registerLazySingleton<CarRemoteDataSource>(
    () => CarRemoteDataSourceImpl(
      secureStorage: getIt(),
      dio: getIt(),
    ),
  );
}
