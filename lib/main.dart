import 'package:discrete_math/core/bfs/bloc/bloc_bfs.dart';
import 'package:discrete_math/core/bfs/service/service_bfs.dart';
import 'package:discrete_math/core/detour/bloc/detour_bloc.dart';
import 'package:discrete_math/core/detour/service/detour_service.dart';
import 'package:discrete_math/core/dfs/bloc/bloc_dfs.dart';
import 'package:discrete_math/core/dfs/service/service_dfs.dart';
import 'package:discrete_math/core/eulerian/bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/eulerian/service/eulirian_service.dart';
import 'package:discrete_math/core/hamiltonian/bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/core/hamiltonian/service/hamiltonian_service.dart';
import 'package:discrete_math/navigation/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://banatube.medium.com/mastering-flutter-custompainter-the-complete-developers-guide-f9b1e8575e6c
//https://medium.com/@punithsuppar7795/exploring-the-interactive-viewer-in-flutter-29fa05f786a5
void main() {
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
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
