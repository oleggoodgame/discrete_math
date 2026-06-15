import 'dart:ui';

import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

extension VertexMapper on Vertex {
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'connection': connection.toList(),
      'offset': {'dx': offset.dx, 'dy': offset.dy},
      'state': state.name,
    };
  }
}

// fromMap — це по суті "фабрика", а extensions НЕ підтримують factory constructors,
// тому робимо static-метод в окремому класі (або top-level функцію)
class VertexMapperFactory {
  static Vertex fromMap(Map<String, dynamic> map) {
    return Vertex(
      data: map['data'] as String,
      connection: Set<String>.from(map['connection'] as List),
      offset: Offset(
        (map['offset']['dx'] as num).toDouble(),
        (map['offset']['dy'] as num).toDouble(),
      ),
      state: VertexState.values.byName(map['state'] as String),
    );
  }
}