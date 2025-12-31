import 'package:discrete_math/data/entity/treeVertex_entity.dart';
import 'package:discrete_math/presentation/screen/add_treeVertex_screen.dart';
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
        path: '/editor',
        builder: (context, state) {
          final vertex = state.extra as TreeVertex;
          return AddTreeVertexScreen(editor: true, vertex: vertex);
        },
      ),
      GoRoute(
        path: '/addVertex',
        builder: (context, state) {
          return AddTreeVertexScreen();
        },
      ),
    ],
  );
});
