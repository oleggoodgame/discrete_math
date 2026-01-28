import 'dart:collection';

import 'package:discrete_math/application/data/entity/vertex_entity.dart';

class DfsService {
  Stream<Set<Vertex>> dfsSteps({
    required Vertex start,
    required Map<String, Vertex> graph,
  }) async* {
    final stack = Queue<Vertex>();
    final visited = <Vertex>{};
    print(graph.toString());
    // print("Start $start");
    stack.add(start);
    while (stack.isNotEmpty) {
      final current = stack.last;
      print("Queue: $stack");
      print("Current: $current");

      final visiting = current.copyWith(state: VertexState.visiting);
      visited.add(visiting);

      yield {...visited};
      await Future.delayed(const Duration(milliseconds: 300));
      print("Visited: $visited");
      final connection = current.connection;
      final String? firstConnection = connection.firstWhere(
        (id) => !visited.any((v) => v.data == id),
        orElse: () => "",
      );
      print(firstConnection);
      final neighbor = graph[firstConnection];
      final fifi = visited.where((v) => v.data == firstConnection).toSet();

      if (neighbor != null && fifi.isEmpty) {
        print(visited.any((v) => v.data != neighbor.data));
        print("FIFI: $fifi");
        stack.add(neighbor);
      } else {
        stack.removeLast();
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
