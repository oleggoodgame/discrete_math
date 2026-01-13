import 'package:discrete_math/core/hamiltonian/type/hamiltonian_type.dart';
import 'package:discrete_math/data/entity/vertex_entity.dart';

class HamiltonianService {
  HamiltonianAnalysis analyze({required Set<Vertex> vertices}) {
    final degreeOne = vertices.where((v) => v.connection.length == 1).toList();

    if (degreeOne.length > 2) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation:
            'More than two vertices with degree 1 → Hamiltonian path is impossible',
      );
    }

    if (degreeOne.length == 2) {
      return HamiltonianAnalysis(
        type: HamiltonianType.path,
        startVertex: degreeOne.first,
        explanation:
            'Exactly two vertices with degree 1 → the path starts from one of them',
      );
    }

    final hasIsolated = vertices.any((v) => v.connection.isEmpty);
    if (hasIsolated) {
      return HamiltonianAnalysis(
        type: HamiltonianType.none,
        explanation: 'There is an isolated peak',
      );
    }

    return HamiltonianAnalysis(
      type: HamiltonianType.cycle,
      explanation: 'No vertices with degree 1 → possible Hamiltonian cycle',
    );
  }
}
