import 'package:equatable/equatable.dart';

class Group extends Equatable {
  const Group(this.name, this.id);
  final String name;
  final GroupId id;
  @override
  List<Object> get props => [name, id];
}

class GroupId extends Equatable {
  const GroupId(
      {required this.facult, required this.course, required this.group});
  final int facult;
  final int course;
  final int group;
  @override
  List<Object> get props => [facult, course, group];
}
