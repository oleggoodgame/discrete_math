// import 'dart:ui';

// class TreeVertex<T> {
//   final String id;
//   final T data;
//   final List<String> connection;
//   final Offset offset;

//   TreeVertex({
//     required this.id,
//     required this.data,
//     required this.connection,
//     required this.offset,
//   });
// }
import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'treeVertex_entity.freezed.dart';

@freezed
class TreeVertex with _$TreeVertex {
  const factory TreeVertex({
    required String id,
    required String data,
    required List<String> connection,
    required Offset offset,
  }) = _TreeVertex;
}
