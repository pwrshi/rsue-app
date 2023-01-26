// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentEntity _$PaymentEntityFromJson(Map<String, dynamic> json) {
  return _PaymentEntity.fromJson(json);
}

/// @nodoc
mixin _$PaymentEntity {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get dateOfReceiptFormation => throw _privateConstructorUsedError;
  DateTime get dateOfServiceStarting => throw _privateConstructorUsedError;
  DateTime get dateOfServiceEnding => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentEntityCopyWith<PaymentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentEntityCopyWith<$Res> {
  factory $PaymentEntityCopyWith(
          PaymentEntity value, $Res Function(PaymentEntity) then) =
      _$PaymentEntityCopyWithImpl<$Res, PaymentEntity>;
  @useResult
  $Res call(
      {String name,
      String url,
      DateTime dateOfReceiptFormation,
      DateTime dateOfServiceStarting,
      DateTime dateOfServiceEnding});
}

/// @nodoc
class _$PaymentEntityCopyWithImpl<$Res, $Val extends PaymentEntity>
    implements $PaymentEntityCopyWith<$Res> {
  _$PaymentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? dateOfReceiptFormation = null,
    Object? dateOfServiceStarting = null,
    Object? dateOfServiceEnding = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfReceiptFormation: null == dateOfReceiptFormation
          ? _value.dateOfReceiptFormation
          : dateOfReceiptFormation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateOfServiceStarting: null == dateOfServiceStarting
          ? _value.dateOfServiceStarting
          : dateOfServiceStarting // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateOfServiceEnding: null == dateOfServiceEnding
          ? _value.dateOfServiceEnding
          : dateOfServiceEnding // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentEntityCopyWith<$Res>
    implements $PaymentEntityCopyWith<$Res> {
  factory _$$_PaymentEntityCopyWith(
          _$_PaymentEntity value, $Res Function(_$_PaymentEntity) then) =
      __$$_PaymentEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String url,
      DateTime dateOfReceiptFormation,
      DateTime dateOfServiceStarting,
      DateTime dateOfServiceEnding});
}

/// @nodoc
class __$$_PaymentEntityCopyWithImpl<$Res>
    extends _$PaymentEntityCopyWithImpl<$Res, _$_PaymentEntity>
    implements _$$_PaymentEntityCopyWith<$Res> {
  __$$_PaymentEntityCopyWithImpl(
      _$_PaymentEntity _value, $Res Function(_$_PaymentEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? dateOfReceiptFormation = null,
    Object? dateOfServiceStarting = null,
    Object? dateOfServiceEnding = null,
  }) {
    return _then(_$_PaymentEntity(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfReceiptFormation: null == dateOfReceiptFormation
          ? _value.dateOfReceiptFormation
          : dateOfReceiptFormation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateOfServiceStarting: null == dateOfServiceStarting
          ? _value.dateOfServiceStarting
          : dateOfServiceStarting // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateOfServiceEnding: null == dateOfServiceEnding
          ? _value.dateOfServiceEnding
          : dateOfServiceEnding // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentEntity implements _PaymentEntity {
  const _$_PaymentEntity(
      {required this.name,
      required this.url,
      required this.dateOfReceiptFormation,
      required this.dateOfServiceStarting,
      required this.dateOfServiceEnding});

  factory _$_PaymentEntity.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentEntityFromJson(json);

  @override
  final String name;
  @override
  final String url;
  @override
  final DateTime dateOfReceiptFormation;
  @override
  final DateTime dateOfServiceStarting;
  @override
  final DateTime dateOfServiceEnding;

  @override
  String toString() {
    return 'PaymentEntity(name: $name, url: $url, dateOfReceiptFormation: $dateOfReceiptFormation, dateOfServiceStarting: $dateOfServiceStarting, dateOfServiceEnding: $dateOfServiceEnding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentEntity &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.dateOfReceiptFormation, dateOfReceiptFormation) ||
                other.dateOfReceiptFormation == dateOfReceiptFormation) &&
            (identical(other.dateOfServiceStarting, dateOfServiceStarting) ||
                other.dateOfServiceStarting == dateOfServiceStarting) &&
            (identical(other.dateOfServiceEnding, dateOfServiceEnding) ||
                other.dateOfServiceEnding == dateOfServiceEnding));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url,
      dateOfReceiptFormation, dateOfServiceStarting, dateOfServiceEnding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentEntityCopyWith<_$_PaymentEntity> get copyWith =>
      __$$_PaymentEntityCopyWithImpl<_$_PaymentEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentEntityToJson(
      this,
    );
  }
}

abstract class _PaymentEntity implements PaymentEntity {
  const factory _PaymentEntity(
      {required final String name,
      required final String url,
      required final DateTime dateOfReceiptFormation,
      required final DateTime dateOfServiceStarting,
      required final DateTime dateOfServiceEnding}) = _$_PaymentEntity;

  factory _PaymentEntity.fromJson(Map<String, dynamic> json) =
      _$_PaymentEntity.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  DateTime get dateOfReceiptFormation;
  @override
  DateTime get dateOfServiceStarting;
  @override
  DateTime get dateOfServiceEnding;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentEntityCopyWith<_$_PaymentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
