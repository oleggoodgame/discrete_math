import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/detour_usecase.dart';
import 'package:discrete_math/shared/errors/error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  late DetourUsecase detourUsecase;
  setUp(() {
    detourUsecase = DetourUsecase();
  });
  test('Тестування при шляху', () async {
    final vertexes = {
      Vertex(data: 'A', connection: {'B', 'E'}, offset: Offset.zero),
      Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
      Vertex(data: 'C', connection: {'B', 'D'}, offset: Offset.zero),
      Vertex(data: 'D', connection: {'K', 'H'}, offset: Offset.zero),
      Vertex(data: 'H', connection: {'D', 'G'}, offset: Offset.zero),
      Vertex(data: 'G', connection: {'E', 'H', 'F', 'I'}, offset: Offset.zero),
      Vertex(data: 'E', connection: {'A', 'G'}, offset: Offset.zero),
      Vertex(data: 'F', connection: {'G', 'O'}, offset: Offset.zero),
      Vertex(data: 'O', connection: {'F', 'L'}, offset: Offset.zero),
      Vertex(data: 'L', connection: {'O', 'W'}, offset: Offset.zero),
      Vertex(data: 'W', connection: {'M', 'L'}, offset: Offset.zero),
      Vertex(data: 'M', connection: {'I', 'W'}, offset: Offset.zero),
      Vertex(data: 'I', connection: {'G', 'M'}, offset: Offset.zero),
    };
    final vertexesMap = {for (final v in vertexes) v.data: v};
    final result = await detourUsecase(
      find: Vertex(data: 'W', connection: {'L', 'M'}, offset: Offset.zero),
      start: Vertex(data: 'A', connection: {'B', 'E'}, offset: Offset.zero),
      graph: vertexesMap,
    );
    expect(result, {
      Vertex(
        data: 'A',
        connection: {'B', 'E'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
      Vertex(
        data: 'E',
        connection: {'A', 'G'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
      Vertex(
        data: 'G',
        connection: {'E', 'H', 'F', 'I'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
      Vertex(
        data: 'I',
        connection: {'G', 'M'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
      Vertex(
        data: 'W',
        connection: {'M', 'L'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
      Vertex(
        data: 'M',
        connection: {'I', 'W'},
        offset: Offset.zero,
        state: VertexState.visited,
      ),
    });
  });

  test('Перевірка якщо нічого не конектиться ', () async {
    final vertexes = {
      Vertex(data: 'A', connection: {'B', 'E', 'K'}, offset: Offset.zero),
      Vertex(data: 'B', connection: {'A', 'C'}, offset: Offset.zero),
      Vertex(data: 'C', connection: {'B', 'D'}, offset: Offset.zero),
      Vertex(data: 'D', connection: {'K', 'H'}, offset: Offset.zero),
      Vertex(data: 'H', connection: {'D', 'G'}, offset: Offset.zero),
      Vertex(data: 'G', connection: {'E', 'H', 'F', 'I'}, offset: Offset.zero),
      Vertex(data: 'E', connection: {'A', 'G'}, offset: Offset.zero),
      Vertex(data: 'F', connection: {'G', 'O'}, offset: Offset.zero),
      Vertex(data: 'O', connection: {'F', 'L'}, offset: Offset.zero),
      Vertex(data: 'L', connection: {'O'}, offset: Offset.zero),
      Vertex(data: 'W', connection: {}, offset: Offset.zero),
      Vertex(data: 'M', connection: {'I'}, offset: Offset.zero),
      Vertex(data: 'I', connection: {'G', 'M'}, offset: Offset.zero),
    };
    final vertexesMap = {for (final v in vertexes) v.data: v};
    await expectLater(
      () => detourUsecase(
        find: Vertex(data: 'W', connection: {'L', 'M'}, offset: Offset.zero),
        start: Vertex(data: 'A', connection: {'B', 'E'}, offset: Offset.zero),
        graph: vertexesMap,
      ),
      throwsA(isA<DetourFailure>()),
    );
  });
}
