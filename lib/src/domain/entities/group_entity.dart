import 'package:freezed_annotation/freezed_annotation.dart';
part 'group_entity.freezed.dart';
part 'group_entity.g.dart';

@freezed
class Group with _$Group {
  const factory Group(String name, GroupId id) = _Group;
}

@freezed
class GroupId with _$GroupId {
  const factory GroupId(
      {required int facult,
      required int course,
      required int group}) = _GroupId;
  factory GroupId.fromJson(Map<String, Object?> json) =>
      _$GroupIdFromJson(json);
}
