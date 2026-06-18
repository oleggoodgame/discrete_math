import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

class VertexModel extends Vertex {
  const VertexModel({
    required super.data,
    required super.connection,
    required super.offset,
    super.state = VertexState.idle,
  });

  factory VertexModel.fromEntity(Vertex entity) {
    return VertexModel(
      data: entity.data,
      connection: entity.connection,
      offset: entity.offset,
      state: entity.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'connection': connection.toList(),
      'offset': {'dx': offset.dx, 'dy': offset.dy},
      'state': state.name,
    };
  }

  factory VertexModel.fromMap(Map<String, dynamic> map) {
    return VertexModel(
      data: map['data'] as String,
      connection: Set<String>.from(map['connection'] as List),
      offset: Offset(
        (map['offset']['dx'] as num).toDouble(),
        (map['offset']['dy'] as num).toDouble(),
      ),
      state: VertexState.values.byName(map['state'] as String),
    );
  }
  // factory Set<VertexModel>.fromSetVertex(Set<Vertex> data) {
  //   final Set<VertexModel> vertexModelSet = {};
  //   for (var v in data) {
  //     vertexModelSet.add(VertexModel.fromEntity(v));
  //   }
  //   return vertexModelSet;
  // }// так не мож як я розумію? 
  static Set<VertexModel> fromSetVertex(Set<Vertex> data) {
    final Set<VertexModel> vertexModelSet = {};
    for (var v in data) {
      vertexModelSet.add(VertexModel.fromEntity(v));
    }
    return vertexModelSet;
  }
  String toJson() => json.encode(toMap());

  factory VertexModel.fromJson(String source) =>
      VertexModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
