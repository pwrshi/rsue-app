// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lesson_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AbstractLesson _$AbstractLessonFromJson(Map<String, dynamic> json) {
  return _AbstractLesson.fromJson(json);
}

/// @nodoc
mixin _$AbstractLesson {
  String get name => throw _privateConstructorUsedError;
  String get teachersname => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;
  LessonType get type => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String? get subgroup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AbstractLessonCopyWith<AbstractLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbstractLessonCopyWith<$Res> {
  factory $AbstractLessonCopyWith(
          AbstractLesson value, $Res Function(AbstractLesson) then) =
      _$AbstractLessonCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String teachersname,
      String room,
      LessonType type,
      String time,
      String? subgroup});
}

/// @nodoc
class _$AbstractLessonCopyWithImpl<$Res>
    implements $AbstractLessonCopyWith<$Res> {
  _$AbstractLessonCopyWithImpl(this._value, this._then);

  final AbstractLesson _value;
  // ignore: unused_field
  final $Res Function(AbstractLesson) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? room = freezed,
    Object? type = freezed,
    Object? time = freezed,
    Object? subgroup = freezed,
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
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      subgroup: subgroup == freezed
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_AbstractLessonCopyWith<$Res>
    implements $AbstractLessonCopyWith<$Res> {
  factory _$$_AbstractLessonCopyWith(
          _$_AbstractLesson value, $Res Function(_$_AbstractLesson) then) =
      __$$_AbstractLessonCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String teachersname,
      String room,
      LessonType type,
      String time,
      String? subgroup});
}

/// @nodoc
class __$$_AbstractLessonCopyWithImpl<$Res>
    extends _$AbstractLessonCopyWithImpl<$Res>
    implements _$$_AbstractLessonCopyWith<$Res> {
  __$$_AbstractLessonCopyWithImpl(
      _$_AbstractLesson _value, $Res Function(_$_AbstractLesson) _then)
      : super(_value, (v) => _then(v as _$_AbstractLesson));

  @override
  _$_AbstractLesson get _value => super._value as _$_AbstractLesson;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? room = freezed,
    Object? type = freezed,
    Object? time = freezed,
    Object? subgroup = freezed,
  }) {
    return _then(_$_AbstractLesson(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: teachersname == freezed
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      subgroup: subgroup == freezed
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AbstractLesson implements _AbstractLesson {
  const _$_AbstractLesson(
      {required this.name,
      required this.teachersname,
      required this.room,
      required this.type,
      required this.time,
      this.subgroup});

  factory _$_AbstractLesson.fromJson(Map<String, dynamic> json) =>
      _$$_AbstractLessonFromJson(json);

  @override
  final String name;
  @override
  final String teachersname;
  @override
  final String room;
  @override
  final LessonType type;
  @override
  final String time;
  @override
  final String? subgroup;

  @override
  String toString() {
    return 'AbstractLesson(name: $name, teachersname: $teachersname, room: $room, type: $type, time: $time, subgroup: $subgroup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AbstractLesson &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.teachersname, teachersname) &&
            const DeepCollectionEquality().equals(other.room, room) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.subgroup, subgroup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(teachersname),
      const DeepCollectionEquality().hash(room),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(subgroup));

  @JsonKey(ignore: true)
  @override
  _$$_AbstractLessonCopyWith<_$_AbstractLesson> get copyWith =>
      __$$_AbstractLessonCopyWithImpl<_$_AbstractLesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AbstractLessonToJson(
      this,
    );
  }
}

abstract class _AbstractLesson implements AbstractLesson {
  const factory _AbstractLesson(
      {required final String name,
      required final String teachersname,
      required final String room,
      required final LessonType type,
      required final String time,
      final String? subgroup}) = _$_AbstractLesson;

  factory _AbstractLesson.fromJson(Map<String, dynamic> json) =
      _$_AbstractLesson.fromJson;

  @override
  String get name;
  @override
  String get teachersname;
  @override
  String get room;
  @override
  LessonType get type;
  @override
  String get time;
  @override
  String? get subgroup;
  @override
  @JsonKey(ignore: true)
  _$$_AbstractLessonCopyWith<_$_AbstractLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

ConcreteLesson _$ConcreteLessonFromJson(Map<String, dynamic> json) {
  return _ConcreteLesson.fromJson(json);
}

/// @nodoc
mixin _$ConcreteLesson {
  String get name => throw _privateConstructorUsedError;
  String get teachersname => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;
  LessonType get type => throw _privateConstructorUsedError;
  String? get subgroup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConcreteLessonCopyWith<ConcreteLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConcreteLessonCopyWith<$Res> {
  factory $ConcreteLessonCopyWith(
          ConcreteLesson value, $Res Function(ConcreteLesson) then) =
      _$ConcreteLessonCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String teachersname,
      DateTime startTime,
      DateTime endTime,
      String room,
      LessonType type,
      String? subgroup});
}

/// @nodoc
class _$ConcreteLessonCopyWithImpl<$Res>
    implements $ConcreteLessonCopyWith<$Res> {
  _$ConcreteLessonCopyWithImpl(this._value, this._then);

  final ConcreteLesson _value;
  // ignore: unused_field
  final $Res Function(ConcreteLesson) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? room = freezed,
    Object? type = freezed,
    Object? subgroup = freezed,
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
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      subgroup: subgroup == freezed
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ConcreteLessonCopyWith<$Res>
    implements $ConcreteLessonCopyWith<$Res> {
  factory _$$_ConcreteLessonCopyWith(
          _$_ConcreteLesson value, $Res Function(_$_ConcreteLesson) then) =
      __$$_ConcreteLessonCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String teachersname,
      DateTime startTime,
      DateTime endTime,
      String room,
      LessonType type,
      String? subgroup});
}

/// @nodoc
class __$$_ConcreteLessonCopyWithImpl<$Res>
    extends _$ConcreteLessonCopyWithImpl<$Res>
    implements _$$_ConcreteLessonCopyWith<$Res> {
  __$$_ConcreteLessonCopyWithImpl(
      _$_ConcreteLesson _value, $Res Function(_$_ConcreteLesson) _then)
      : super(_value, (v) => _then(v as _$_ConcreteLesson));

  @override
  _$_ConcreteLesson get _value => super._value as _$_ConcreteLesson;

  @override
  $Res call({
    Object? name = freezed,
    Object? teachersname = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? room = freezed,
    Object? type = freezed,
    Object? subgroup = freezed,
  }) {
    return _then(_$_ConcreteLesson(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: teachersname == freezed
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      subgroup: subgroup == freezed
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConcreteLesson implements _ConcreteLesson {
  const _$_ConcreteLesson(
      {required this.name,
      required this.teachersname,
      required this.startTime,
      required this.endTime,
      required this.room,
      required this.type,
      this.subgroup});

  factory _$_ConcreteLesson.fromJson(Map<String, dynamic> json) =>
      _$$_ConcreteLessonFromJson(json);

  @override
  final String name;
  @override
  final String teachersname;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String room;
  @override
  final LessonType type;
  @override
  final String? subgroup;

  @override
  String toString() {
    return 'ConcreteLesson(name: $name, teachersname: $teachersname, startTime: $startTime, endTime: $endTime, room: $room, type: $type, subgroup: $subgroup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConcreteLesson &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.teachersname, teachersname) &&
            const DeepCollectionEquality().equals(other.startTime, startTime) &&
            const DeepCollectionEquality().equals(other.endTime, endTime) &&
            const DeepCollectionEquality().equals(other.room, room) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.subgroup, subgroup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(teachersname),
      const DeepCollectionEquality().hash(startTime),
      const DeepCollectionEquality().hash(endTime),
      const DeepCollectionEquality().hash(room),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(subgroup));

  @JsonKey(ignore: true)
  @override
  _$$_ConcreteLessonCopyWith<_$_ConcreteLesson> get copyWith =>
      __$$_ConcreteLessonCopyWithImpl<_$_ConcreteLesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConcreteLessonToJson(
      this,
    );
  }
}

abstract class _ConcreteLesson implements ConcreteLesson {
  const factory _ConcreteLesson(
      {required final String name,
      required final String teachersname,
      required final DateTime startTime,
      required final DateTime endTime,
      required final String room,
      required final LessonType type,
      final String? subgroup}) = _$_ConcreteLesson;

  factory _ConcreteLesson.fromJson(Map<String, dynamic> json) =
      _$_ConcreteLesson.fromJson;

  @override
  String get name;
  @override
  String get teachersname;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get room;
  @override
  LessonType get type;
  @override
  String? get subgroup;
  @override
  @JsonKey(ignore: true)
  _$$_ConcreteLessonCopyWith<_$_ConcreteLesson> get copyWith =>
      throw _privateConstructorUsedError;
}
