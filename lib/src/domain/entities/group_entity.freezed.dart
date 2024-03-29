// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Group {
  String get name => throw _privateConstructorUsedError;
  GroupId get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({String name, GroupId id});

  $GroupIdCopyWith<$Res> get id;
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as GroupId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupIdCopyWith<$Res> get id {
    return $GroupIdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, GroupId id});

  @override
  $GroupIdCopyWith<$Res> get id;
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res, _$_Group>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$_Group(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as GroupId,
    ));
  }
}

/// @nodoc

class _$_Group implements _Group {
  const _$_Group(this.name, this.id);

  @override
  final String name;
  @override
  final GroupId id;

  @override
  String toString() {
    return 'Group(name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);
}

abstract class _Group implements Group {
  const factory _Group(final String name, final GroupId id) = _$_Group;

  @override
  String get name;
  @override
  GroupId get id;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupId _$GroupIdFromJson(Map<String, dynamic> json) {
  return _GroupId.fromJson(json);
}

/// @nodoc
mixin _$GroupId {
  int get facult => throw _privateConstructorUsedError;
  int get course => throw _privateConstructorUsedError;
  int get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupIdCopyWith<GroupId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupIdCopyWith<$Res> {
  factory $GroupIdCopyWith(GroupId value, $Res Function(GroupId) then) =
      _$GroupIdCopyWithImpl<$Res, GroupId>;
  @useResult
  $Res call({int facult, int course, int group});
}

/// @nodoc
class _$GroupIdCopyWithImpl<$Res, $Val extends GroupId>
    implements $GroupIdCopyWith<$Res> {
  _$GroupIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facult = null,
    Object? course = null,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      facult: null == facult
          ? _value.facult
          : facult // ignore: cast_nullable_to_non_nullable
              as int,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupIdCopyWith<$Res> implements $GroupIdCopyWith<$Res> {
  factory _$$_GroupIdCopyWith(
          _$_GroupId value, $Res Function(_$_GroupId) then) =
      __$$_GroupIdCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int facult, int course, int group});
}

/// @nodoc
class __$$_GroupIdCopyWithImpl<$Res>
    extends _$GroupIdCopyWithImpl<$Res, _$_GroupId>
    implements _$$_GroupIdCopyWith<$Res> {
  __$$_GroupIdCopyWithImpl(_$_GroupId _value, $Res Function(_$_GroupId) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facult = null,
    Object? course = null,
    Object? group = null,
  }) {
    return _then(_$_GroupId(
      facult: null == facult
          ? _value.facult
          : facult // ignore: cast_nullable_to_non_nullable
              as int,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupId implements _GroupId {
  const _$_GroupId(
      {required this.facult, required this.course, required this.group});

  factory _$_GroupId.fromJson(Map<String, dynamic> json) =>
      _$$_GroupIdFromJson(json);

  @override
  final int facult;
  @override
  final int course;
  @override
  final int group;

  @override
  String toString() {
    return 'GroupId(facult: $facult, course: $course, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupId &&
            (identical(other.facult, facult) || other.facult == facult) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, facult, course, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupIdCopyWith<_$_GroupId> get copyWith =>
      __$$_GroupIdCopyWithImpl<_$_GroupId>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupIdToJson(
      this,
    );
  }
}

abstract class _GroupId implements GroupId {
  const factory _GroupId(
      {required final int facult,
      required final int course,
      required final int group}) = _$_GroupId;

  factory _GroupId.fromJson(Map<String, dynamic> json) = _$_GroupId.fromJson;

  @override
  int get facult;
  @override
  int get course;
  @override
  int get group;
  @override
  @JsonKey(ignore: true)
  _$$_GroupIdCopyWith<_$_GroupId> get copyWith =>
      throw _privateConstructorUsedError;
}
