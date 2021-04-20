import 'package:chopper/chopper.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/usecases/change_password.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/presentation/blocs/change_password/bloc.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/repositories/home_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/repositories/home_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/usecases/logout_user.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/presentation/blocs/log_out/bloc.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/repositories/login_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/fetch_token.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/usecases/login_user.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/presentation/blocs/user_login/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/change_password/data/datasources/change_password_local_datasource.dart';
import 'screens/login/data/datasources/login_local_datasource.dart';
import 'screens/login/data/datasources/login_remote_datasource.dart';
import 'screens/login/domain/repositories/login_repository.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerFactory(
    () => UserLoginBloc(
      loginUser: sl(),
      fetchToken: sl(),
    )..add(CheckLoginStatusEvent()),
  );
  sl.registerFactory(
    () => LogOutBloc(
      fetchToken: sl(),
      logoutUser: sl(),
    ),
  );
  sl.registerFactory(
    () => ChangePasswordBloc(
      changePassword: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => FetchToken(repository: sl()));
  sl.registerLazySingleton(() => LogOutUser(repository: sl()));
  sl.registerLazySingleton(() => ChangePassword(repository: sl()));

  //Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        networkInfo: sl(),
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordRepositoryImpl(
    networkInfo: sl(),
    localDataSource: sl(),
    remoteDataSource: sl(),
  ));


  //Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<ChangePasswordLocalDataSource>(
        () => ChangePasswordLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );

  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  final client = ChopperClient(interceptors: [
    CurlInterceptor(),
    HttpLoggingInterceptor(),
  ]);
  sl.registerLazySingleton(() => RestClientService.create(client));
}
