import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedVertexProvider = StateProvider<Vertex?>((ref) => null);

final selectedToConnectProvider = StateProvider<Map<Vertex, Vertex?>?>((ref)=> null);

// final graphBlocProvider = Provider<BfsBloc>((ref) {
//   return BfsBloc(service: BfsService());
// });