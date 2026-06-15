import 'dart:collection';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

class BfsUsecase {
  Stream<Set<Vertex>> call({
    required Vertex start,
    required Map<String, Vertex> graph,
  }) async* {
    final queue = Queue<Vertex>();
    final visited = <Vertex>{};
    final seen = <String>{};
    // print(graph.toString());
    // print("Start $start");
    queue.add(start);
    seen.add(start.data);

    // visited.add(start);
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      print("Queue: $queue \n");
      print("Current: $current \n");
      final visiting = current.copyWith(state: VertexState.visiting);
      visited.add(visiting);

      yield {...visited};
      await Future.delayed(const Duration(milliseconds: 300));
      // print("Visited: $visited");
      for (final id in current.connection) {
        final neighbor = graph[id];
        if (neighbor != null && !seen.contains(id)) {
          queue.add(neighbor);
          seen.add(id);
        }
      }

      final done = visiting.copyWith(state: VertexState.visited);
      visited
        ..remove(visiting)
        ..add(done);
      print("END: $visited");
      yield {...visited};
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }
}