import 'package:discrete_math/core/graph/hamiltonian/type/hamiltonian_type.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';

class HamiltonianService {
  HamiltonianAnalysis analyze({required Map<String, Vertex> graph}) {
    final vertices = graph.values.toList();

    for (final start in vertices) {
      final visited = <String>{};

      if (_dfs(start, graph, visited, vertices.length)) {
        return HamiltonianAnalysis(
          type: HamiltonianType.path,
          explanation: 'Hamiltonian path exists',
        );
      }
    }

    return HamiltonianAnalysis(
      type: HamiltonianType.none,
      explanation: 'No Hamiltonian path',
    );
  }

  bool _dfs(
    Vertex current,
    Map<String, Vertex> graph,
    Set<String> visited,
    int total,
  ) {
    visited.add(current.data);

    if (visited.length == total) {
      return true;
    }

    for (final neighborId in current.connection) {
      if (!visited.contains(neighborId)) {
        if (_dfs(graph[neighborId]!, graph, visited, total)) {
          return true;
        }
      }
    }

    visited.remove(current.data);
    return false;
  }
}
