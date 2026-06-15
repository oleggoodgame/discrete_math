import 'dart:convert';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/graph/data/model/vertex_mapper.dart';

class GraphModel extends GraphEntity {
  GraphModel({
    required super.id,
    required super.title,
    required super.data,
    required super.createdAt,
  });

  factory GraphModel.fromMap(Map<String, dynamic> map) {
    return GraphModel(
      id: map['id'] as String,
      title: map['title'] as String,
      data: (map['data'] as List)
          .map((e) => VertexMapperFactory.fromMap(e as Map<String, dynamic>))
          .toSet(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'data': data.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
  factory GraphModel.fromJson(String source) => GraphModel.fromMap(json.decode(source));

  factory GraphModel.fromEntity(GraphEntity entity) {
    return GraphModel(
      id: entity.id,
      title: entity.title,
      data: entity.data,
      createdAt: entity.createdAt,
    );
  }
}