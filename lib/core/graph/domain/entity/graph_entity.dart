import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:flutter/foundation.dart';

class GraphEntity {
  final String title;
  final Set<Vertex> data;
  final DateTime createdAt;
  final String id;
  GraphEntity({
    required this.title,
    required this.data,
    required this.createdAt,
    required this.id,
  });

  GraphEntity copyWith({
    String? title,
    Set<Vertex>? data,
    DateTime? createdAt,
    String? id,
  }) {
    return GraphEntity(
      title: title ?? this.title,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'GraphEntity(title: $title, data: $data, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(covariant GraphEntity other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        setEquals(other.data, data) &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^ data.hashCode ^ createdAt.hashCode ^ id.hashCode;
  }
}
