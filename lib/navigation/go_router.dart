import 'package:discrete_math/data/entity/vertex_entity.dart';
import 'package:discrete_math/presentation/screen/edit_vertex_screen.dart';
import 'package:discrete_math/presentation/screen/editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/editor',
    redirect: (context, state) {
      return null;
    },
    routes: [
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
    ],
  );
});
