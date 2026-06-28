import 'package:discrete_math/core/graph/domain/entity/hamiltionian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

class HamiltonianUsecase {
  HamiltonianAnalysis call({required Map<String, Vertex> graph}) {
    if (graph.isEmpty) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation: 'Empty graph',
      );
    }

    if (graph.length == 1) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation: 'Single vertex',
      );
    }

    final vertices = graph.values.toList();
    if (graph.length == 2) {
      final firstVertex = graph[vertices.first.data]!;
      final secondVertex = graph[vertices.last.data]!;
      if (firstVertex.connection.contains(secondVertex.data)) {
        return HamiltonianAnalysis(
          type: HamiltonianType.path,
          explanation: 'Hamiltonian path exists',
        );
      }
    }
    if (vertices.any((v) => v.connection.isEmpty)) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation: 'Isolated vertex',
      );
    }
    // я це не розумію нащо
    final degreeOneCount = vertices
        .where((v) => v.connection.length == 1)
        .length;
    if (degreeOneCount > 2) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation: 'Too many leaves',
      );
    }

    bool hasPath = false;

    for (final start in vertices) {
      final visited = <String>[];

      if (_dfs(start, graph, visited, vertices.length)) {
        final lastVertex = graph[visited.last]!;

        // перевіряємо cycle
        if (lastVertex.connection.contains(visited.first)) {
          return HamiltonianAnalysis(
            type: HamiltonianType.cycle,
            explanation: 'Cycle: ${visited.join(' → ')} → ${visited.first}',
          );
        }

        hasPath = true;
      }
    }

    if (hasPath) {
      return HamiltonianAnalysis(
        type: HamiltonianType.path,
        explanation: 'Hamiltonian path exists',
      );
    }

    return HamiltonianAnalysis(
      type: HamiltonianType.none,
      explanation: 'No Hamiltonian path or cycle',
    );
  }

  bool _dfs(
    Vertex current,
    Map<String, Vertex> graph,
    List<String> visited,
    int total,
  ) {
    visited.add(current.data);

    if (visited.length == total) return true;

    for (final neighborId in current.connection) {
      if (!visited.contains(neighborId) && graph.containsKey(neighborId)) {
        if (_dfs(graph[neighborId]!, graph, visited, total)) {
          return true;
        }
      }
    }

    visited.removeLast();
    return false;
  }
}
