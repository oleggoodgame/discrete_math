// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'treeVertex_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TreeVertex {
  String get id => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  List<String> get connection => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;

  /// Create a copy of TreeVertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreeVertexCopyWith<TreeVertex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeVertexCopyWith<$Res> {
  factory $TreeVertexCopyWith(
    TreeVertex value,
    $Res Function(TreeVertex) then,
  ) = _$TreeVertexCopyWithImpl<$Res, TreeVertex>;
  @useResult
  $Res call({String id, String data, List<String> connection, Offset offset});
}

/// @nodoc
class _$TreeVertexCopyWithImpl<$Res, $Val extends TreeVertex>
    implements $TreeVertexCopyWith<$Res> {
  _$TreeVertexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreeVertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? connection = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as String,
            connection: null == connection
                ? _value.connection
                : connection // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as Offset,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TreeVertexImplCopyWith<$Res>
    implements $TreeVertexCopyWith<$Res> {
  factory _$$TreeVertexImplCopyWith(
    _$TreeVertexImpl value,
    $Res Function(_$TreeVertexImpl) then,
  ) = __$$TreeVertexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String data, List<String> connection, Offset offset});
}

/// @nodoc
class __$$TreeVertexImplCopyWithImpl<$Res>
    extends _$TreeVertexCopyWithImpl<$Res, _$TreeVertexImpl>
    implements _$$TreeVertexImplCopyWith<$Res> {
  __$$TreeVertexImplCopyWithImpl(
    _$TreeVertexImpl _value,
    $Res Function(_$TreeVertexImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreeVertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? connection = null,
    Object? offset = null,
  }) {
    return _then(
      _$TreeVertexImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as String,
        connection: null == connection
            ? _value._connection
            : connection // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as Offset,
      ),
    );
  }
}

/// @nodoc

class _$TreeVertexImpl implements _TreeVertex {
  const _$TreeVertexImpl({
    required this.id,
    required this.data,
    required final List<String> connection,
    required this.offset,
  }) : _connection = connection;

  @override
  final String id;
  @override
  final String data;
  final List<String> _connection;
  @override
  List<String> get connection {
    if (_connection is EqualUnmodifiableListView) return _connection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connection);
  }

  @override
  final Offset offset;

  @override
  String toString() {
    return 'TreeVertex(id: $id, data: $data, connection: $connection, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreeVertexImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(
              other._connection,
              _connection,
            ) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    data,
    const DeepCollectionEquality().hash(_connection),
    offset,
  );

  /// Create a copy of TreeVertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreeVertexImplCopyWith<_$TreeVertexImpl> get copyWith =>
      __$$TreeVertexImplCopyWithImpl<_$TreeVertexImpl>(this, _$identity);
}

abstract class _TreeVertex implements TreeVertex {
  const factory _TreeVertex({
    required final String id,
    required final String data,
    required final List<String> connection,
    required final Offset offset,
  }) = _$TreeVertexImpl;

  @override
  String get id;
  @override
  String get data;
  @override
  List<String> get connection;
  @override
  Offset get offset;

  /// Create a copy of TreeVertex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreeVertexImplCopyWith<_$TreeVertexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
