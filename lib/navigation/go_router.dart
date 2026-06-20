import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/auth/auth/presentation/provider/auth_state_provider.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_bfs.dart';
import 'package:discrete_math/core/graph/presentation/bloc/detoure_bloc/detour_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_dfs.dart';
import 'package:discrete_math/core/graph/presentation/bloc/eulirian_bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/hamiltonian_bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/core/settings/presentation/screen/app_info_screen.dart';
import 'package:discrete_math/core/auth/login/presentation/screen/login_screen.dart';
import 'package:discrete_math/core/auth/signup/presentation/screen/signup_screen.dart';
import 'package:discrete_math/core/graph/presentation/screen/edit_vertex_screen.dart';
import 'package:discrete_math/core/graph/presentation/screen/editor_screen.dart';
import 'package:discrete_math/core/favorite/presentation/screen/favorite_screen.dart';
import 'package:discrete_math/core/graph/presentation/screen/graphs_screen.dart';
import 'package:discrete_math/core/graph/presentation/screen/information_screen.dart';
import 'package:discrete_math/core/settings/presentation/screen/more_screen.dart';
import 'package:discrete_math/core/settings/presentation/screen/settings_screen.dart';
import 'package:discrete_math/injections/service_locator.dart';
import 'package:discrete_math/shared/widgets/main_shell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/graphs',
    redirect: (context, state) {
      final auth = ref.watch(authStateProvider);
      final loggedIn = auth.value != null;

      final isAuthRoute =
          state.uri.path == '/login' || state.uri.path == '/signup';

      if (!loggedIn && !isAuthRoute) {
        return '/login';
      }

      if (loggedIn && isAuthRoute) {
        return '/graphs';
      }

      return null;
    },
    onException: (context, state, router) {
      
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          return SignupScreen();
        },
      ),
      // GoRoute(
      //   path: '/graphs',
      //   builder: (context, state) {
      //     return GraphsScreen();
      //   },
      // ),
      GoRoute(
        path: '/editor',
        builder: (context, state) {
          final graph = state.extra as GraphEntity;

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => DfsBloc(dfsUsecase: getIt())),
              BlocProvider(create: (_) => BfsBloc(bfsUsecase: getIt())),
              BlocProvider(create: (_) => DetourBloc(detourUsecase: getIt())),
            ],
            child: EditorScreen(graph: graph),
          );
        },
      ),
      GoRoute(
        path: '/edit_vertex',
        builder: (context, state) {
          final vertex = state.extra as Vertex;
          return EditVertexScreen(editor: true, vertex: vertex);
        },
      ),
      GoRoute(
        path: '/add_vertex',
        builder: (context, state) {
          return EditVertexScreen();
        },
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) {
          return FavoriteScreen();
        },
      ),
      GoRoute(
        path: '/app_info',
        builder: (context, state) => const AppInfoScreen(),
      ),
      GoRoute(
        path: '/information_screen',
        builder: (context, state) {
          final graph = state.extra as GraphEntity;
          return MultiBlocProvider(
            providers: [
              BlocProvider<HamiltonianBloc>(
                create: (_) => HamiltonianBloc(service: getIt()),
              ),
              BlocProvider<EulerianBloc>(
                create: (_) => EulerianBloc(service: getIt()),
              ),
            ],
            child: InformationScreen(graph: graph),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellWidget(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/graphs',
                builder: (context, state) => GraphsScreen(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: '/favorites',
          //       builder: (context, state) => FavoritesScreen(),
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => SettingsScreen(),
                routes: [
                  GoRoute(
                    path: '/more',
                    builder: (context, state) {
                      return MoreScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
