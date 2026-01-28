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
    required String data,
    required Set<String> connection,
    required Offset offset,
    @Default(VertexState.idle) VertexState state,
  }) = _Vertex;
}
extension VertexMapper on Vertex {
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'connection': connection.toList(),
      'offset': {
        'dx': offset.dx,
        'dy': offset.dy,
      },
      'state': state.name,
    };
  }

  static Vertex fromMap(Map<String, dynamic> map) {
    return Vertex(
      data: map['data'] as String,
      connection: Set<String>.from(map['connection']),
      offset: Offset(
        (map['offset']['dx'] as num).toDouble(),
        (map['offset']['dy'] as num).toDouble(),
      ),
      state: VertexState.values.byName(map['state']),
    );
  }
}

