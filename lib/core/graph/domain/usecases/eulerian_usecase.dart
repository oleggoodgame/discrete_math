import 'package:discrete_math/core/graph/domain/entity/eulerian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

class EulerianUsecase {
  EulerianType call({required Set<Vertex> vertices}) {
    print('Start new usecase');
    if (vertices.length <= 1) {
      return EulerianType.none;
    }
    if (!isConnected(vertices)) {
      return EulerianType.none;
    }

    final oddCount = vertices
        .where((v) => (v.connection.length % 2 != 0))
        .length;
    final evenCount = vertices.where((element) {
      return element.connection.length % 2 == 0 &&
          element.connection.isNotEmpty;
    }).length;
    if (oddCount == 0 && evenCount >= 1) {
      return EulerianType.cycle;
    } else if (oddCount == 2 && evenCount >= 0) {
      return EulerianType.path;
    } else {
      return EulerianType.none;
    }
  }

}

bool isConnected(Set<Vertex> vertices) {
  final withEdges = vertices
      .where((v) => v.connection.isNotEmpty)
      .toList(); //Ми получаємо список де граф має ШОСЬ в собі

  if (withEdges.isEmpty) return false;

  final visited = <String>{};
  final stack = [withEdges.first];
  print(visited);
  print(stack);
  print('\n');
  while (stack.isNotEmpty) {
    final current = stack.removeLast();
    if (visited.contains(current.data)) continue;

    visited.add(current.data);

    for (final id in current.connection) {
      final neighbor = vertices.firstWhere((v) => v.data == id);
      stack.add(neighbor);
      print(neighbor);
    }
  }
  print('\n');
  print(withEdges.every((v) => visited.contains(v.data)));
  return (withEdges.every((v) => visited.contains(v.data)) &&
      vertices.length == withEdges.length);
}
