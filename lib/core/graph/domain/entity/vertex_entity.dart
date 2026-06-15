// domain/entity/vertex_entity.dart

import 'dart:ui';

enum VertexState { idle, visiting, visited }

class Vertex {
  final String data;
  final Set<String> connection;
  final Offset offset;
  final VertexState state;

  const Vertex({
    required this.data,
    required this.connection,
    required this.offset,
    this.state = VertexState.idle,
  });

  Vertex copyWith({
    String? data,
    Set<String>? connection,
    Offset? offset,
    VertexState? state,
  }) {
    return Vertex(
      data: data ?? this.data,
      connection: connection ?? this.connection,
      offset: offset ?? this.offset,
      state: state ?? this.state,
    );
  }

  @override
  bool operator ==(covariant Vertex other) {
    if (identical(this, other)) return true;
    return other.data == data &&
        _setEquals(other.connection, connection) &&
        other.offset == offset &&
        other.state == state;
  }

  @override
  int get hashCode =>
      data.hashCode ^ connection.hashCode ^ offset.hashCode ^ state.hashCode;

  @override
  String toString() =>
      'Vertex(data: $data, connection: $connection, offset: $offset, state: $state)';
}

// просте порівняння множин без залежності від package:flutter/foundation.dart
bool _setEquals<T>(Set<T> a, Set<T> b) {
  if (a.length != b.length) return false;
  return a.containsAll(b);
}