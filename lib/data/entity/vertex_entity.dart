// import 'dart:ui';

// class TreeVertex<T> {
//   final String data;
//   final T data;
//   final List<String> connection;
//   final Offset offset;

//   TreeVertex({
//     required this.data,
//     required this.data,
//     required this.connection,
//     required this.offset,
//   });
// }
import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vertex_entity.freezed.dart';
enum VertexState {
  idle,
  visiting,
  visited,
}
@freezed
class Vertex with _$Vertex {
  const factory Vertex({
    // required String data,
    required String data,
    required Set<String> connection,
    required Offset offset,
     @Default(VertexState.idle) VertexState state,
  }) = _Vertex;
}
