  import 'package:discrete_math/core/graph/domain/entity/eulerian_type.dart';
  import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

  class EulerianUsecase{
  Stream<EulerianType> call({required Set<Vertex> vertices}) async* {
      if (!isConnected(vertices)) {
        yield EulerianType.none;
        return;
      }

      final oddCount = vertices.where((v) => v.connection.length % 2 != 0).length;

      if (oddCount == 0) {
        yield EulerianType.cycle;
      } else if (oddCount == 2) {
        yield EulerianType.path;
      } else {
        yield EulerianType.none;
      }
    }
  }

  bool isConnected(Set<Vertex> vertices) {
    final withEdges = vertices.where((v) => v.connection.isNotEmpty).toList();

    if (withEdges.isEmpty) return true;

    final visited = <String>{};
    final stack = [withEdges.first];

    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      if (visited.contains(current.data)) continue;

      visited.add(current.data);

      for (final id in current.connection) {
        final neighbor = vertices.firstWhere((v) => v.data == id);
        stack.add(neighbor);
      }
    }

    return withEdges.every((v) => visited.contains(v.data));
  }
