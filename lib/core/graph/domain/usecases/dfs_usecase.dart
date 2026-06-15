import 'dart:collection';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

class DfsUsecase {
  Stream<Set<Vertex>> call({
    required Vertex start,
    required Map<String, Vertex> graph,
  }) async* {
    final stack = Queue<Vertex>();
    final visited = <Vertex>{};
    print(graph.toString());
    final seen = <String>{};

    print("Start $start");
    stack.add(start);
    seen.add(start.data);

    while (stack.isNotEmpty) {
      final current = stack.last;
      print("Stack: $stack");
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

      if (neighbor != null && !seen.contains(neighbor.data)) {
        print(visited.any((v) => v.data != neighbor.data));
        seen.add(neighbor.data);
        stack.add(neighbor);
      } else {
        stack.removeLast();
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
