// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'subject_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) {
  return _SubjectEntity.fromJson(json);
}

/// @nodoc
mixin _$SubjectEntity {
  String get name => throw _privateConstructorUsedError;
  String get teachersname => throw _privateConstructorUsedError;
  SessionType get type => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;
  int get statement => throw _privateConstructorUsedError;
  List<int> get controlPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubjectEntityCopyWith<SubjectEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectEntityCopyWith<$Res> {
  factory $SubjectEntityCopyWith(
          SubjectEntity value, $Res Function(SubjectEntity) then) =
      _$SubjectEntityCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String teachersname,
      SessionType type,
      bool isClosed,
      int statement,
      List<int> controlPoints});
}

/// @nodoc
class _$SubjectEntityCopyWithImpl<$Res>
    implements $SubjectEntityCopyWith<$Res> {
  _$SubjectEntityCopyWithImpl(this._value, this._then);

  final SubjectEntity _value;
  // ignore: unused_field
  final $Res Function(SubjectEntity) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? type = freezed,
    Object? isClosed = freezed,
    Object? statement = freezed,
    Object? controlPoints = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: teachersname == freezed
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SessionType,
      isClosed: isClosed == freezed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      statement: statement == freezed
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as int,
      controlPoints: controlPoints == freezed
          ? _value.controlPoints
          : controlPoints // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$$_SubjectEntityCopyWith<$Res>
    implements $SubjectEntityCopyWith<$Res> {
  factory _$$_SubjectEntityCopyWith(
          _$_SubjectEntity value, $Res Function(_$_SubjectEntity) then) =
      __$$_SubjectEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String teachersname,
      SessionType type,
      bool isClosed,
      int statement,
      List<int> controlPoints});
}

/// @nodoc
class __$$_SubjectEntityCopyWithImpl<$Res>
    extends _$SubjectEntityCopyWithImpl<$Res>
    implements _$$_SubjectEntityCopyWith<$Res> {
  __$$_SubjectEntityCopyWithImpl(
      _$_SubjectEntity _value, $Res Function(_$_SubjectEntity) _then)
      : super(_value, (v) => _then(v as _$_SubjectEntity));

  @override
  _$_SubjectEntity get _value => super._value as _$_SubjectEntity;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? type = freezed,
    Object? isClosed = freezed,
    Object? statement = freezed,
    Object? controlPoints = freezed,
  }) {
    return _then(_$_SubjectEntity(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: teachersname == freezed
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SessionType,
      isClosed: isClosed == freezed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      statement: statement == freezed
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as int,
      controlPoints: controlPoints == freezed
          ? _value._controlPoints
          : controlPoints // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubjectEntity extends _SubjectEntity {
  const _$_SubjectEntity(
      {required this.name,
      required this.teachersname,
      required this.type,
      required this.isClosed,
      required this.statement,
      required final List<int> controlPoints})
      : _controlPoints = controlPoints,
        super._();

  factory _$_SubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$$_SubjectEntityFromJson(json);

  @override
  final String name;
  @override
  final String teachersname;
  @override
  final SessionType type;
  @override
  final bool isClosed;
  @override
  final int statement;
  final List<int> _controlPoints;
  @override
  List<int> get controlPoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_controlPoints);
  }

  @override
  String toString() {
    return 'SubjectEntity(name: $name, teachersname: $teachersname, type: $type, isClosed: $isClosed, statement: $statement, controlPoints: $controlPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubjectEntity &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.teachersname, teachersname) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.isClosed, isClosed) &&
            const DeepCollectionEquality().equals(other.statement, statement) &&
            const DeepCollectionEquality()
                .equals(other._controlPoints, _controlPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(teachersname),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isClosed),
      const DeepCollectionEquality().hash(statement),
      const DeepCollectionEquality().hash(_controlPoints));

  @JsonKey(ignore: true)
  @override
  _$$_SubjectEntityCopyWith<_$_SubjectEntity> get copyWith =>
      __$$_SubjectEntityCopyWithImpl<_$_SubjectEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubjectEntityToJson(
      this,
    );
  }
}

abstract class _SubjectEntity extends SubjectEntity {
  const factory _SubjectEntity(
      {required final String name,
      required final String teachersname,
      required final SessionType type,
      required final bool isClosed,
      required final int statement,
      required final List<int> controlPoints}) = _$_SubjectEntity;
  const _SubjectEntity._() : super._();

  factory _SubjectEntity.fromJson(Map<String, dynamic> json) =
      _$_SubjectEntity.fromJson;

  @override
  String get name;
  @override
  String get teachersname;
  @override
  SessionType get type;
  @override
  bool get isClosed;
  @override
  int get statement;
  @override
  List<int> get controlPoints;
  @override
  @JsonKey(ignore: true)
  _$$_SubjectEntityCopyWith<_$_SubjectEntity> get copyWith =>
      throw _privateConstructorUsedError;
}