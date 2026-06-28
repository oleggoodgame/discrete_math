import 'package:discrete_math/core/graph/domain/entity/hamiltionian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/hamiltonian_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HamiltonianUsecase useCase;

  setUp(() => useCase = HamiltonianUsecase());

  group('HamiltonianUsecase', () {
    test('повертає none коли всі вершини ізольовані', () {
      final vertices = {
        'A': Vertex(data: 'A', connection: {}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.none);
    });

    test('повертає none для порожнього графа', () {
      expect(useCase(graph: {}).type, HamiltonianType.none);
    });

    test('повертає path для лінійного графа A-B-C', () {
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'B'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.path);
    });

    test('повертає cycle для повного графа трикутника', () {
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B', 'C'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'A', 'B'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.cycle);
    });
  });
  // Hamiltonian — складніші варіанти
  group('HamiltonianUsecase — складні випадки', () {
    test('граф з двома вершинами і ребром між ними повертає path', () {
      // A — B: єдиний шлях, проходить всі вершини → path
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.path);
    });

    test('квадрат повертає cycle', () {
      // A-B-C-D-A: проходить всі 4 вершини і повертається → cycle
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B', 'D'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'B', 'D'}, offset: Offset.zero),
        'D': Vertex(data: 'D', connection: {'C', 'A'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.cycle);
    });

    test('зірка з центром A не має Гамільтонового шляху', () {
      // A з'єднана з B,C,D але B,C,D між собою НЕ з'єднані
      // з B не можна перейти до C або D (тільки через A)
      // отже неможливо пройти всі вершини без повторення → none
      final vertices = {
        'A': Vertex(
          data: 'A',
          connection: {'B', 'C', 'D'},
          offset: Offset.zero,
        ),
        'B': Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'A'}, offset: Offset.zero),
        'D': Vertex(data: 'D', connection: {'A'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.none);
    });

    test('граф з 5 вершинами у формі циклу повертає cycle', () {
      // A-B-C-D-E-A: класичний Гамільтонів цикл
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B', 'E'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'B', 'D'}, offset: Offset.zero),
        'D': Vertex(data: 'D', connection: {'C', 'E'}, offset: Offset.zero),
        'E': Vertex(data: 'E', connection: {'D', 'A'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.cycle);
    });

    test('незвязний граф з 4 вершинами повертає none', () {
      // A-B і C-D — дві окремі пари, між ними немає ребер
      // неможливо пройти всі вершини → none
      final vertices = {
        'A': Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        'B': Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
        'C': Vertex(data: 'C', connection: {'D'}, offset: Offset.zero),
        'D': Vertex(data: 'D', connection: {'C'}, offset: Offset.zero),
      };
      expect(useCase(graph: vertices).type, HamiltonianType.none);
    });
  });
}
