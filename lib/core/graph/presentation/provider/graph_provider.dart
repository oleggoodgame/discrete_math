import 'dart:ui';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_provider.g.dart';
@riverpod
class GraphProvider extends _$GraphProvider {
  @override
  Set<Vertex> build() => {};

  Set<Vertex>? _snapshot;

  void addVertex(Vertex vertex) {
    for (final i in vertex.connection) {
      connectVertices(vertex.data, i);
    }
    state = {...state, vertex};
  }

  void setHead(Vertex vertex) {
    state = {vertex, ...state.where((v) => v.data != vertex.data)};
  }

  void updateOffset(String data, Offset position) {
    state = {
      for (final v in state)
        if (v.data == data) v.copyWith(offset: position) else v,
    };
  }

  void remove(Vertex vertex) {
    state = state
        .where((v) => v != vertex)
        .map((v) => v.copyWith(
              connection: v.connection.where((c) => c != vertex.data).toSet(),
            ))
        .toSet();
  }

  void connectVertices(String a, String b) {
    if (a == b) return;

    state = {
      for (final v in state)
        if (v.data == a)
          v.connection.contains(b)
              ? v.copyWith(
                  connection: v.connection.where((w) => w != b).toSet(),
                )
              : v.copyWith(connection: {...v.connection, b})
        else if (v.data == b)
          v.connection.contains(a)
              ? v.copyWith(
                  connection: v.connection.where((w) => w != a).toSet(),
                )
              : v.copyWith(connection: {...v.connection, a})
        else
          v,
    };
  }

  void editVertex(Vertex updated, Vertex oldOne) {
    if (oldOne.connection.length < updated.connection.length) {
      final newConnections = updated.connection.difference(oldOne.connection);
      for (final i in newConnections) {
        connectVertices(updated.data, i);
      }
    } else if (oldOne.connection.length == updated.connection.length) {
      final changed = updated.connection
          .difference(oldOne.connection)
          .union(oldOne.connection.difference(updated.connection));
      for (final i in changed) {
        connectVertices(updated.data, i);
      }
    } else {
      final removed = oldOne.connection.difference(updated.connection);
      for (final i in removed) {
        connectVertices(updated.data, i);
      }
    }
  }

  void setVertices(Set<Vertex> vertices) {
    state = vertices;
  }

  void takeSnapshot() {
    _snapshot = state.map((v) => v.copyWith()).toSet();
  }

  void restoreSnapshot() {
    if (_snapshot != null) {
      state = _snapshot!;
      _snapshot = null;
    }
  }

  bool get isAlgorithmRunning =>
      state.any((v) => v.state != VertexState.idle);
}