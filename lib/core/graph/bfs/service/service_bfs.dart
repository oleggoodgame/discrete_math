import 'dart:collection';

import 'package:discrete_math/application/data/entity/vertex_entity.dart';

class BfsService {
  Stream<Set<Vertex>> bfsSteps({
    required Vertex start,
    required Map<String, Vertex> graph,
  }) async* {
    final queue = Queue<Vertex>();
    final visited = <Vertex>{};
    print(graph.toString());
    // print("Start $start");
    queue.add(start);
    // visited.add(start);
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      // print("Queue: $queue");
      // print("Current: $current");
      final visiting = current.copyWith(state: VertexState.visiting);
      visited.add(visiting);

      yield {...visited}; 
      await Future.delayed(const Duration(milliseconds: 300));
      // print("Visited: $visited");
      for (final id in current.connection) {
        final neighbor = graph[id];
        final fifi = visited.where((v)=>v.data==id).toSet();
        // print("FIFI: $fifi");
        if (neighbor != null && fifi.isEmpty) {
          // print(visited.any((v) => v.data != neighbor.data));
          // print("ID: $id");
          queue.add(neighbor);
        }
      }

      final done = visiting.copyWith(state: VertexState.visited);
      visited
        ..remove(visiting)
        ..add(done);
      // print("END: $visited");
      yield {...visited};
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }
}
