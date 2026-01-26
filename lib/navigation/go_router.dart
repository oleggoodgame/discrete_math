import 'package:discrete_math/application/provider/auth_state_provider.dart';
import 'package:discrete_math/data/entity/vertex_entity.dart';
import 'package:discrete_math/presentation/screen/authentication/login_screen.dart';
import 'package:discrete_math/presentation/screen/authentication/signup_screen.dart';
import 'package:discrete_math/presentation/screen/edit_vertex_screen.dart';
import 'package:discrete_math/presentation/screen/editor_screen.dart';
import 'package:discrete_math/presentation/screen/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  final authProvider = ref.watch(authStateProvider);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/editor',
    redirect: (context, state) {
  final auth = ref.watch(authStateProvider);
  final loggedIn = auth.value != null;

  final isAuthRoute =
      state.uri.path == '/login' || state.uri.path == '/signup';

  if (!loggedIn && !isAuthRoute) {
    return '/login';
  }

  if (loggedIn && isAuthRoute) {
    return '/editor';
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
      GoRoute(
        path: '/editor',
        builder: (context, state) {
          return EditorScreen();
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
        path: '/information_screen',
        builder: (context, state) {
          return InformationScreen();
        },
      ),
    ],
  );
});
