import 'package:discrete_math/core/bfs/bloc/bloc_bfs.dart';
import 'package:discrete_math/core/bfs/service/service_bfs.dart';
import 'package:discrete_math/data/entity/vertex_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedVertexProvider = StateProvider<Vertex?>((ref) => null);

final selectedToConnectProvider = StateProvider<Map<Vertex, Vertex?>?>((ref)=> null);

final graphBlocProvider = Provider<BfsBloc>((ref) {
  return BfsBloc(service: BfsService());
});