// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vertex_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Vertex {
  String get data => throw _privateConstructorUsedError;
  Set<String> get connection => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  VertexState get state => throw _privateConstructorUsedError;

  /// Create a copy of Vertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VertexCopyWith<Vertex> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VertexCopyWith<$Res> {
  factory $VertexCopyWith(Vertex value, $Res Function(Vertex) then) =
      _$VertexCopyWithImpl<$Res, Vertex>;
  @useResult
  $Res call({
    String data,
    Set<String> connection,
    Offset offset,
    VertexState state,
  });
}

/// @nodoc
class _$VertexCopyWithImpl<$Res, $Val extends Vertex>
    implements $VertexCopyWith<$Res> {
  _$VertexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? connection = null,
    Object? offset = null,
    Object? state = null,
  }) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as String,
            connection: null == connection
                ? _value.connection
                : connection // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as Offset,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as VertexState,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VertexImplCopyWith<$Res> implements $VertexCopyWith<$Res> {
  factory _$$VertexImplCopyWith(
    _$VertexImpl value,
    $Res Function(_$VertexImpl) then,
  ) = __$$VertexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String data,
    Set<String> connection,
    Offset offset,
    VertexState state,
  });
}

/// @nodoc
class __$$VertexImplCopyWithImpl<$Res>
    extends _$VertexCopyWithImpl<$Res, _$VertexImpl>
    implements _$$VertexImplCopyWith<$Res> {
  __$$VertexImplCopyWithImpl(
    _$VertexImpl _value,
    $Res Function(_$VertexImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? connection = null,
    Object? offset = null,
    Object? state = null,
  }) {
    return _then(
      _$VertexImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as String,
        connection: null == connection
            ? _value._connection
            : connection // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as Offset,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as VertexState,
      ),
    );
  }
}

/// @nodoc

class _$VertexImpl implements _Vertex {
  const _$VertexImpl({
    required this.data,
    required final Set<String> connection,
    required this.offset,
    this.state = VertexState.idle,
  }) : _connection = connection;

  @override
  final String data;
  final Set<String> _connection;
  @override
  Set<String> get connection {
    if (_connection is EqualUnmodifiableSetView) return _connection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_connection);
  }

  @override
  final Offset offset;
  @override
  @JsonKey()
  final VertexState state;

  @override
  String toString() {
    return 'Vertex(data: $data, connection: $connection, offset: $offset, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VertexImpl &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(
              other._connection,
              _connection,
            ) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    data,
    const DeepCollectionEquality().hash(_connection),
    offset,
    state,
  );

  /// Create a copy of Vertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VertexImplCopyWith<_$VertexImpl> get copyWith =>
      __$$VertexImplCopyWithImpl<_$VertexImpl>(this, _$identity);
}

abstract class _Vertex implements Vertex {
  const factory _Vertex({
    required final String data,
    required final Set<String> connection,
    required final Offset offset,
    final VertexState state,
  }) = _$VertexImpl;

  @override
  String get data;
  @override
  Set<String> get connection;
  @override
  Offset get offset;
  @override
  VertexState get state;

  /// Create a copy of Vertex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VertexImplCopyWith<_$VertexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
