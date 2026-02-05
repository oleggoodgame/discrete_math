import 'dart:ui';

import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_provider.g.dart';

@riverpod
class GraphProvider extends _$GraphProvider {
  @override
  Set<Vertex> build() {
    return {};
    //   Vertex(data: 'A', offset: const Offset(100, 100), connection: {'B', 'C'}),
    //   Vertex(data: 'B', offset: const Offset(200, 200), connection: {'A'}),
    //   Vertex(
    //     data: 'C',
    //     offset: const Offset(300, 100),
    //     connection: {'A', 'D', 'V'},
    //   ),
    //   Vertex(data: 'D', offset: const Offset(300, 300), connection: {'C', 'Q'}),
    //   Vertex(
    //     data: 'Q',
    //     offset: const Offset(400, 400),
    //     connection: {'D', 'V', 'U'},
    //   ),

    //   Vertex(data: 'V', offset: const Offset(400, 300), connection: {'C', 'Q'}),

    //   Vertex(data: 'U', offset: const Offset(200, 500), connection: {'V', 'Q'}),
    // };
  }

  Set<Vertex>? _snapshot;

  void addVertex(Vertex vertex) {
    for (final i in vertex.connection) {
      connectVertices(vertex.data, i);
    }
    state = {...state, vertex};
  }

  void setHead(Vertex vertex) {
    final updated = {vertex, ...state.where((v) => v.data != vertex.data)};

    state = updated;
  }

  void updateOffset(String data, Offset position) {
    state = {
      for (final v in state)
        if (v.data == data) v.copyWith(offset: position) else v,
    };
  }

  void remove(Vertex vertex) {
    state = {
      for (final v in state)
        if (v == vertex)
          null
        else
          v.copyWith(
            connection: v.connection.where((c) => c != vertex.data).toSet(),
          ),
    }.whereType<Vertex>().toSet();
  }

  void connectVertices(String a, String b) {
    if (a == b) return;
    // final List<Vertex> newList = [];
    // for (final v in state) {
    //   if (v.data == a) {
    //     v.connection.contains(b)
    //         ? v.copyWith(connection: v.connection.where((w) => w != b).toList())
    //         : v.copyWith(connection: [...v.connection, b]);
    //     print("WORK ON a ");
    //     print(v);

    //     newList.add(v);
    //   }
    //   if (v.data == b) {
    //     v.connection.contains(a)
    //         ? v.copyWith(connection: v.connection.where((w) => w != a).toList())
    //         : v.copyWith(connection: [...v.connection, a]);
    //     print("WORK ON b ");
    //     print(v);

    //     newList.add(v);
    //   } else
    //     newList.add(v);
    // }
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
    // state = newList;
  }

  void editVertex(Vertex updated) {
    final old = state.firstWhere((v) => v.data == updated.data);

    final removed = old.connection.difference(updated.connection);
    final added = updated.connection.difference(old.connection);

    state = {
      for (final v in state)
        if (v.data == updated.data)
          updated
        else if (removed.contains(v.data))
          v.copyWith(
            connection: v.connection.where((c) => c != updated.data).toSet(),
          )
        else if (added.contains(v.data))
          v.copyWith(connection: {...v.connection, updated.data})
        else
          v,
    };
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

  bool get isAlgorithmRunning => state.any((v) => v.state != VertexState.idle);
  // Vertex find(String neighbor) {}
}
