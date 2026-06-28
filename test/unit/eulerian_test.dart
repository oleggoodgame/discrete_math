import 'package:discrete_math/core/graph/domain/entity/eulerian_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:discrete_math/core/graph/domain/usecases/eulerian_usecase.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

void main() {
  late EulerianUsecase useCase;

  setUp(() => useCase = EulerianUsecase());

  group('EulerianUseCase', () {
    test('повертає cycle коли всі вершини мають парний ступінь', () {
      final vertices = {
        Vertex(data: 'A', connection: {'B', 'C'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        Vertex(data: 'C', connection: {'A', 'B'}, offset: Offset.zero),
      };
      expect(useCase(vertices: vertices), EulerianType.cycle);
    });

    test('повертає path коли рівно 2 вершини мають непарний ступінь', () {
      final vertices = {
        Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        Vertex(data: 'C', connection: {'B'}, offset: Offset.zero),
      };
      expect(useCase(vertices: vertices), EulerianType.path);
    });
    print('///////////////////////');
    test('повертає none коли граф незвязний', () {
      final vertices = {
        Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
        Vertex(data: 'C', connection: {}, offset: Offset.zero), 
        Vertex(data: 'D', connection: {}, offset: Offset.zero), 
      };
      expect(useCase(vertices: vertices), EulerianType.none);
    });
    print('///////////////////////');

    test('повертає none для порожнього графа', () {
      expect(useCase(vertices: {}), EulerianType.none);
    });
    print('///////////////////////');
  });
  // Eulerian — складніші варіанти
  group('EulerianUseCase — складні випадки', () {
    test('граф з однією вершиною без ребер повертає none', () {
      final vertices = {Vertex(data: 'A', connection: {}, offset: Offset.zero)};
      expect(useCase(vertices: vertices), EulerianType.none);
    });

    test('граф з двома вершинами і одним ребром повертає path', () {
      // A — B
      // A має непарний ступінь (1), B має непарний ступінь (1) → path
      final vertices = {
        Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
      };
      expect(useCase(vertices: vertices), EulerianType.path);
    });

    test('граф з 4 вершинами де всі мають парний ступінь повертає cycle', () {
      // квадрат: A-B-C-D-A
      // кожна вершина має ступінь 2 (парний) → cycle
      final vertices = {
        Vertex(data: 'A', connection: {'B', 'D'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
        Vertex(data: 'C', connection: {'B', 'D'}, offset: Offset.zero),
        Vertex(data: 'D', connection: {'C', 'A'}, offset: Offset.zero),
      };
      expect(useCase(vertices: vertices), EulerianType.cycle);
    });

    test('граф з 4 вершинами де 4 мають непарний ступінь повертає none', () {
      // A-B, A-C, B-D, C-D (кожна вершина має ступінь 2, але...)
      // A: з'єднана з B,C → ступінь 2 (парний)
      // B: з'єднана з A,D → ступінь 2 (парний)
      // насправді це cycle — тому змінимо приклад:
      // граф де 4 вершини мають непарний ступінь:
      // A-B, A-C, A-D (зірка з центром A)
      // A: ступінь 3 (непарний)
      // B,C,D: ступінь 1 (непарний)
      // 4 вершини з непарним ступінем → none
      final vertices = {
        Vertex(data: 'A', connection: {'B', 'C', 'D'}, offset: Offset.zero),
        Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
        Vertex(data: 'C', connection: {'A'}, offset: Offset.zero),
        Vertex(data: 'D', connection: {'A'}, offset: Offset.zero),
      };
      expect(useCase(vertices: vertices), EulerianType.none);
    });

    test(
      'незвязний граф де кожна компонента має парні ступені повертає none',
      () {
        // дві окремі "петлі": A-B-A і C-D-C
        // кожна вершина має парний ступінь, АЛЕ граф незвязний
        // Ейлерів цикл вимагає ЗВЯЗНОСТІ → none
        final vertices = {
          Vertex(data: 'A', connection: {'B'}, offset: Offset.zero),
          Vertex(data: 'B', connection: {'A'}, offset: Offset.zero),
          Vertex(
            data: 'C',
            connection: {'D'},
            offset: Offset.zero,
          ), // окрема компонента
          Vertex(data: 'D', connection: {'C'}, offset: Offset.zero),
        };
        expect(useCase(vertices: vertices), EulerianType.none);
      },
    );
  });
}
