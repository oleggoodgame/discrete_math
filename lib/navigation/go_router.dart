import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';
import 'package:discrete_math/application/provider/auth_state_provider.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:discrete_math/presentation/screen/app_info_screen.dart';
import 'package:discrete_math/presentation/screen/authentication/login_screen.dart';
import 'package:discrete_math/presentation/screen/authentication/signup_screen.dart';
import 'package:discrete_math/presentation/screen/edit_vertex_screen.dart';
import 'package:discrete_math/presentation/screen/editor_screen.dart';
import 'package:discrete_math/presentation/screen/favorite_screen.dart';
import 'package:discrete_math/presentation/screen/graphs_screen.dart';
import 'package:discrete_math/presentation/screen/information_screen.dart';
import 'package:discrete_math/presentation/screen/more_screen.dart';
import 'package:discrete_math/presentation/screen/settings_screen.dart';
import 'package:discrete_math/presentation/widget/main_%20shell_widget.dart';
import 'package:flutter/material.dart';
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
          return EditorScreen(graph: graph);
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
          return InformationScreen(graph: graph);
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
