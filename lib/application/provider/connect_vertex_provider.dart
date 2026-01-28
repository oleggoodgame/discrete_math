import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connect_vertex_provider.g.dart';

final fifiConectProvider = StateProvider<bool>((ref) => false);

@riverpod
class ConnectVertex extends _$ConnectVertex {
  @override
  String? build() => null;

  bool get isActive => state != null;

  void start(Vertex vertex) {
    state = vertex.data;
  }

  void connect(Vertex vertex, GraphProvider notifier) {
    if (state == null) return;

    final first = state!;

    if (first == vertex.data) {
      return;
    }

    notifier.connectVertices(first, vertex.data);
    state = null;
  }

  void cancel() => state = null;
}
