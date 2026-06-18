import 'package:discrete_math/core/graph/data/datasrouce/graph_datasource.dart';
import 'package:discrete_math/core/graph/data/repository/graph_repository_impl.dart';
import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';
import 'package:discrete_math/core/graph/domain/usecases/bfs_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/create_graph_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/detour_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/dfs_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/edit_graph_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/eulerian_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/hamiltonian_usecase.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_bfs.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_dfs.dart';
import 'package:discrete_math/core/graph/presentation/bloc/detoure_bloc/detour_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/edit_bloc/edit_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/eulirian_bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/hamiltonian_bloc/hamiltonian_bloc.dart';
import 'package:get_it/get_it.dart';

class GraphInjection {
  final GetIt sl;
  const GraphInjection(this.sl);
  void init() {
    //datasource & repostiory
    sl.registerLazySingleton<GraphDatasource>(() => GraphDatasourceImpl());
    sl.registerLazySingleton<GraphRepository>(
      () => GraphRepositoryImpl(sl<GraphDatasource>()),
    );
    //usecase
    sl.registerLazySingleton(() => CreateGraphUsecase(sl<GraphRepository>()));
    sl.registerLazySingleton(() => EditGraphUsecase(sl<GraphRepository>()));
    sl.registerLazySingleton(() => DfsUsecase());
    sl.registerLazySingleton(() => BfsUsecase());
    sl.registerLazySingleton(() => DetourUsecase());
    sl.registerLazySingleton(() => EulerianUsecase());
    sl.registerLazySingleton(() => HamiltonianUsecase());

    //bloc
    sl.registerFactory<BfsBloc>(() => BfsBloc(bfsUsecase: sl<BfsUsecase>()));
    sl.registerFactory<DfsBloc>(() => DfsBloc(dfsUsecase: sl<DfsUsecase>()));
    sl.registerFactory<DetourBloc>(
      () => DetourBloc(detourUsecase: sl<DetourUsecase>()),
    );

    sl.registerFactory<EditCubit>(
      () => EditCubit(
        editGraphUsecase: sl<EditGraphUsecase>(),
        createGraphUsecase: sl<CreateGraphUsecase>(),
      ),
    );

    sl.registerFactory<EulerianBloc>(
      () => EulerianBloc(service: sl<EulerianUsecase>()),
    );

    sl.registerFactory<GraphsCubit>(() => GraphsCubit(sl<GraphRepository>()));
    sl.registerFactory<HamiltonianBloc>(() => HamiltonianBloc(service: sl<HamiltonianUsecase>()));
  }
}
