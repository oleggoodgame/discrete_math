// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:discrete_math/application/data/entity/vertex_entity.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'data': data.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory GraphEntity.fromMap(Map<String, dynamic> map) {
    return GraphEntity(
      title: map['title'] as String,
      data: (map['data'] as List)
          .map((e) => VertexMapper.fromMap(e as Map<String, dynamic>))
          .toSet(),// thx
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GraphEntity.fromJson(String source) =>
      GraphEntity.fromMap(json.decode(source) as Map<String, dynamic>);

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
