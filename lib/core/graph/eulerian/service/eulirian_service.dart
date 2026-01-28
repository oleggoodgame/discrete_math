import 'package:discrete_math/core/graph/eulerian/type/eulirian_type.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';

class EulirianService {
  Stream<EulerianType> eulerianService({required Set<Vertex> vertices}) async* {
    final oddCount = vertices.where((v) => v.connection.length % 2 != 0).length;

    if (oddCount == 0) {
      yield (EulerianType.cycle);
    } else if (oddCount == 2) {
      yield (EulerianType.path);
    } else {
      yield (EulerianType.none);
    }
  }
}
