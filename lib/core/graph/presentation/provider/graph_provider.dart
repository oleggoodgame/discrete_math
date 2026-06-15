import 'dart:ui';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
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
    print("\n=== connectVertices CALLED ===");
    print("$a, $b");

    if (a == b) {
      print("❌ Same vertex, skip");
      return;
    }

    print("State BEFORE:");
    for (final v in state) {
      print("  ${v.data} -> ${v.connection}");
    }
    for (final v in state) {
      print("$v: ${v.connection}");
      if (v.connection.isEmpty) {
        print("Одне встав ");
      }
      if (v.data == a)
        v.connection.contains(b)
            ? print(v.connection.where((w) => w != b).toSet())
            : print({...v.connection, b});
    }
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
    print("State AFTER:");
    for (final v in state) {
      print("  ${v.data} -> ${v.connection}");
    }

    print("=== connectVertices END ===\n");
  }

  void editVertex(Vertex updated, Vertex oldOne) {
    // {F} // {F, K}
    // {F, K} // {F}
    print("W");
    if (oldOne.connection.length < updated.connection.length) {
      print("FIRST");
      final newOne = updated.connection.difference(oldOne.connection);
      print(newOne);

      for (final i in newOne) {
        connectVertices(updated.data, i);
      }
    } else if (oldOne.connection.length == updated.connection.length) {
      final newOne = updated.connection.difference(oldOne.connection);
      final newOther = oldOne.connection.difference(updated.connection);
      newOther.addAll(newOne);
      print("AAAAAAAAAAAAAAAAAAAAAAA");
      print(updated.connection);
      print(oldOne.connection);

      print(newOther);

      for (final i in newOther) {
        print("WORKED WITH ${updated.data} | $i");
        connectVertices(updated.data, i);
      }
    } else {
      print("SECOND");

      final newOne = oldOne.connection.difference(updated.connection);

      print(newOne);
      for (final i in newOne) {
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

  bool get isAlgorithmRunning => state.any((v) => v.state != VertexState.idle);
  // Vertex find(String neighbor) {}
}
