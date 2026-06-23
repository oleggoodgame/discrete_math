import 'package:discrete_math/core/graph/domain/entity/hamiltionian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/hamiltonian_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  late HamiltonianUsecase hamiltonianUsecase;
  setUp(() {
    hamiltonianUsecase = HamiltonianUsecase();
  });
  tearDown(() {
    print('Наступний тест: ');
  });
  test('Set Up Vertex ', () {
    final vertices = {
      'A': Vertex(data: 'A', connection: {}, offset: Offset.zero),
      'B': Vertex(data: 'B', connection: {}, offset: Offset.zero),
      'C': Vertex(data: 'C', connection: {}, offset: Offset.zero),
    };
    final HamiltonianAnalysis result = hamiltonianUsecase(graph: vertices);
    expect(result.type, HamiltonianType.none);
  });

  test('HamiltonianType.path', () {
    final vertices = {
      'A': Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
      'B': Vertex(data: 'B', connection: {'C'}, offset: Offset.zero),
      'C': Vertex(data: 'C', connection: {}, offset: Offset.zero),
    };
    final HamiltonianAnalysis result = hamiltonianUsecase(graph: vertices);
    expect(result.type, HamiltonianType.path);
  });
  // це не робить
  test('HamiltonianType.cycle', () {// і це чомусь не працює
    final vertices = {
      // A з'єднана з B та C (бо цикл замкнений з обох сторін)
      'A': Vertex(data: 'A', connection: {'B', 'C'}, offset: Offset.zero),
      // B з'єднана з A та C
      'B': Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
      // C з'єднана з B та A
      'C': Vertex(data: 'C', connection: {'B', 'A'}, offset: Offset.zero),
    };
    final HamiltonianAnalysis result = hamiltonianUsecase(graph: vertices);
    expect(result.type, HamiltonianType.cycle);
  });
  // test('HamiltonianType.cycle', () { чомусь це не робить
  //   final vertices = {
  //     'A': Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
  //     'B': Vertex(data: 'B', connection: {'C'}, offset: Offset.zero),
  //     'C': Vertex(data: 'C', connection: {'A'}, offset: Offset.zero),
  //   };
  //   final HamiltonianAnalysis result = hamiltonianUsecase(graph: vertices);
  //   expect(result.type, HamiltonianType.cycle);
  // });
}
