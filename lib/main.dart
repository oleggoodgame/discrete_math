import 'package:discrete_math/core/auth/signup/bloc/signup_bloc.dart';
import 'package:discrete_math/core/auth/signup/service/signup_service.dart';
import 'package:discrete_math/core/graph/bfs/bloc/bloc_bfs.dart';
import 'package:discrete_math/core/graph/bfs/service/service_bfs.dart';
import 'package:discrete_math/core/graph/detour/bloc/detour_bloc.dart';
import 'package:discrete_math/core/graph/detour/service/detour_service.dart';
import 'package:discrete_math/core/graph/dfs/bloc/bloc_dfs.dart';
import 'package:discrete_math/core/graph/dfs/service/service_dfs.dart';
import 'package:discrete_math/core/graph/edit/bloc/edit_bloc.dart';
import 'package:discrete_math/core/graph/edit/service/edit_service.dart';
import 'package:discrete_math/core/graph/eulerian/bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/graph/eulerian/service/eulirian_service.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/graphs/service/graphs_service.dart';
import 'package:discrete_math/core/graph/hamiltonian/bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/core/graph/hamiltonian/service/hamiltonian_service.dart';
import 'package:discrete_math/core/auth/login/bloc/login_bloc.dart';
import 'package:discrete_math/core/auth/login/service/login_service.dart';
import 'package:discrete_math/firebase_options.dart';
import 'package:discrete_math/navigation/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://banatube.medium.com/mastering-flutter-custompainter-the-complete-developers-guide-f9b1e8575e6c
//https://medium.com/@punithsuppar7795/exploring-the-interactive-viewer-in-flutter-29fa05f786a5
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<DetourBloc>(
          create: (_) => DetourBloc(service: DetourService()),
        ),
        BlocProvider<BfsBloc>(create: (_) => BfsBloc(service: BfsService())),
        BlocProvider<DfsBloc>(create: (_) => DfsBloc(service: DfsService())),
        BlocProvider<HamiltonianBloc>(
          create: (_) => HamiltonianBloc(service: HamiltonianService()),
        ),
        BlocProvider<EulerianBloc>(
          create: (_) => EulerianBloc(service: EulirianService()),
        ),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(LoginService())),
        BlocProvider<SignupBloc>(create: (_) => SignupBloc(SignupService())),
        BlocProvider<GraphsCubit>(create: (_) => GraphsCubit(GraphsService())),
        BlocProvider<EditCubit>(create: (_) => EditCubit(EditService())),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
