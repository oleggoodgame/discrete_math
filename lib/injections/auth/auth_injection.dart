import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:discrete_math/core/auth/auth/data/datasource/auth_datasource.dart';
import 'package:discrete_math/core/auth/auth/data/repository/auth_repository_impl.dart';
import 'package:discrete_math/core/auth/auth/domain/repository/auth_repository.dart';
import 'package:discrete_math/core/auth/auth/presentation/bloc/auth_bloc.dart';
import 'package:discrete_math/core/auth/internet_connection/data/repository/connectiviry_repository_impl.dart';
import 'package:discrete_math/core/auth/internet_connection/domain/repository/connectivity_repository.dart';
import 'package:discrete_math/core/auth/internet_connection/presentation/bloc/internet_cubit.dart';
import 'package:discrete_math/core/auth/login/data/datasource/login_firebase_datasource.dart';
import 'package:discrete_math/core/auth/login/data/repository/login_repository.dart';
import 'package:discrete_math/core/auth/login/domain/repository/ilogin_repository.dart';
import 'package:discrete_math/core/auth/signup/data/datasrouce/signup_datasrouce.dart';
import 'package:discrete_math/core/auth/signup/data/repository/signup_repository_impl.dart';
import 'package:discrete_math/core/auth/signup/domain/repostiory/signup_repostiory.dart';
import 'package:discrete_math/core/graph/domain/usecases/loadGraphs_usecase.dart';
import 'package:get_it/get_it.dart';

class AuthInjection {
  final GetIt sl;
  const AuthInjection(this.sl);
  void init() {
    //datasource
    sl.registerLazySingleton<AuthDatasource>(() => GoogleDataSource());
    sl.registerLazySingleton<LoginDatasource>(() => LoginDatasourceImpl());
    sl.registerLazySingleton<SignupDatasrouce>(() => SignupDatasrouceImpl());

    //repository
    sl.registerLazySingleton<ConnectivityRepository>(
      () => ConnectivityRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<Connectivity>(() => Connectivity());

    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthDatasource>()),
    );
    sl.registerLazySingleton<LoginRepostiory>(
      () => LoginRepositoryImpl(sl<LoginDatasource>()),
    );
    sl.registerLazySingleton<SignupRepostiory>(
      () => SignupRepositoryImpl(sl<SignupDatasrouce>()),
    );
    //bloc
    sl.registerFactory<AuthBloc>(
      () => AuthBloc(sl<LoginRepostiory>(), sl<SignupRepostiory>(), sl<LoadgraphsUsecase>()),
    );
    sl.registerFactory<ConnectivityCubit>(
      () => ConnectivityCubit(sl<ConnectivityRepository>()),
    );
  }
}
