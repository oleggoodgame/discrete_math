import 'dart:ui';

import 'package:discrete_math/data/entity/treeVertex_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treeVertex_provider.g.dart';

@riverpod
class TreeVertexProvider extends _$TreeVertexProvider {
  @override
  List<TreeVertex> build() {
    return [
      TreeVertex(
        id: '1',
        data: 'A',
        offset: const Offset(100, 100),
        connection: ['2', '3'],
      ),
      TreeVertex(
        id: '2',
        data: 'B',
        offset: const Offset(200, 200),
        connection: ['1'],
      ),
      TreeVertex(
        id: '3',
        data: 'C',
        offset: const Offset(300, 100),
        connection: ['1'],
      ),
    ];
  }

  void addVertex(TreeVertex vertex) {
    state = [...state, vertex];
  }

  void updateOffset(String id, Offset position) {
    state = [
    for (final v in state)
      if (v.id == id)
        v.copyWith(offset: position)
      else
        v
  ];
  }

  void remove(TreeVertex vertex) {
    state.remove(vertex);
  }
}
