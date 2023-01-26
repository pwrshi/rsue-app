// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$AbstractLessonCopyWithImpl<$Res, AbstractLesson>;
  @useResult
  $Res call(
      {String name,
      String teachersname,
      String room,
      LessonType type,
      String time,
      String? subgroup});
}

/// @nodoc
class _$AbstractLessonCopyWithImpl<$Res, $Val extends AbstractLesson>
    implements $AbstractLessonCopyWith<$Res> {
  _$AbstractLessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? teachersname = null,
    Object? room = null,
    Object? type = null,
    Object? time = null,
    Object? subgroup = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: null == teachersname
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      subgroup: freezed == subgroup
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AbstractLessonCopyWith<$Res>
    implements $AbstractLessonCopyWith<$Res> {
  factory _$$_AbstractLessonCopyWith(
          _$_AbstractLesson value, $Res Function(_$_AbstractLesson) then) =
      __$$_AbstractLessonCopyWithImpl<$Res>;
  @override
  @useResult
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
    extends _$AbstractLessonCopyWithImpl<$Res, _$_AbstractLesson>
    implements _$$_AbstractLessonCopyWith<$Res> {
  __$$_AbstractLessonCopyWithImpl(
      _$_AbstractLesson _value, $Res Function(_$_AbstractLesson) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? teachersname = null,
    Object? room = null,
    Object? type = null,
    Object? time = null,
    Object? subgroup = freezed,
  }) {
    return _then(_$_AbstractLesson(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: null == teachersname
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      subgroup: freezed == subgroup
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.teachersname, teachersname) ||
                other.teachersname == teachersname) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.subgroup, subgroup) ||
                other.subgroup == subgroup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, teachersname, room, type, time, subgroup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$ConcreteLessonCopyWithImpl<$Res, ConcreteLesson>;
  @useResult
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
class _$ConcreteLessonCopyWithImpl<$Res, $Val extends ConcreteLesson>
    implements $ConcreteLessonCopyWith<$Res> {
  _$ConcreteLessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? teachersname = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? room = null,
    Object? type = null,
    Object? subgroup = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: null == teachersname
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      subgroup: freezed == subgroup
          ? _value.subgroup
          : subgroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConcreteLessonCopyWith<$Res>
    implements $ConcreteLessonCopyWith<$Res> {
  factory _$$_ConcreteLessonCopyWith(
          _$_ConcreteLesson value, $Res Function(_$_ConcreteLesson) then) =
      __$$_ConcreteLessonCopyWithImpl<$Res>;
  @override
  @useResult
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
    extends _$ConcreteLessonCopyWithImpl<$Res, _$_ConcreteLesson>
    implements _$$_ConcreteLessonCopyWith<$Res> {
  __$$_ConcreteLessonCopyWithImpl(
      _$_ConcreteLesson _value, $Res Function(_$_ConcreteLesson) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? teachersname = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? room = null,
    Object? type = null,
    Object? subgroup = freezed,
  }) {
    return _then(_$_ConcreteLesson(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      teachersname: null == teachersname
          ? _value.teachersname
          : teachersname // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      subgroup: freezed == subgroup
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.teachersname, teachersname) ||
                other.teachersname == teachersname) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subgroup, subgroup) ||
                other.subgroup == subgroup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, teachersname, startTime,
      endTime, room, type, subgroup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
