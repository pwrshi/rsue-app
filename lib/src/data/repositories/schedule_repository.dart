import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/data/datasource/schedule/offical/schedule_offical.dart';
import 'package:rsue_app/src/data/repositories/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

abstract class ScheduleDatasource {
  Future<Map<int, String>> getFacults();
  Future<Map<int, String>> getCourses(int faculty);
  Future<Map<int, String>> getGroups(int faculty, int course);
  Future<List<Group>> getAllGroups();
  Future<ScheduleService> getScheduleService(GroupId groupId);
}

class ScheduleRepositoryRsueOfficalImpl extends ScheduleRepository {
  Group? group;
  GroupId? groupId;

  ScheduleDatasource? datasource;
  Response<ScheduleService> service =
      const Response(status: ResponseStatus.init);

  @override
  Future<Map<int, String>> getCoursesByFacultId(int faculty) {
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    return datasource!.getCourses(faculty);
  }

  @override
  Future<Map<int, String>> getFacults() {
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    return datasource!.getFacults();
  }

  @override
  Future<List<Group>> getGroups() {
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    return datasource!.getAllGroups();
  }

  @override
  Future<Map<int, String>> getGroupsByFacultIdAndCourseId(
      int faculty, int course) {
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    return datasource!.getGroups(faculty, course);
  }

  @override
  Future<List<ConcreteLesson>> getLessonsOnDay(DateTime date) async {
    if (service.status == ResponseStatus.done) {
      if (service.content == null) {
        throw const RepositoryError(
            name:
                "ЕБАНЫЙ ТВОЙ РОТ, КАКОГО ХУЯ ОНИ В ДРУГОМ ПОРЯДКЕ РАСПОЛОЖЕНЫ!!!");
      }
      return service.content!.getLessonsOnDay(date);
    }
    throw const RepositoryError(name: "Группа не выбрана/Сервис не создан");
  }

  @override
  void setGroup(Group group) {
    this.group = group;
    groupId = group.id;
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    service = const Response(status: ResponseStatus.loading);
    datasource!.getScheduleService(group.id).then((value) {
      service = Response(status: ResponseStatus.done, content: value);
    });
  }

  @override
  void setGroupByGroupId(GroupId groupId) {
    this.groupId = groupId;
    if (datasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    service = const Response(status: ResponseStatus.loading);
    datasource!.getScheduleService(groupId).then((value) {
      service = Response(status: ResponseStatus.done, content: value);
    });
  }

  @override
  void unsetGroup() {
    group = null;
    groupId = null;
    service = const Response(status: ResponseStatus.init);
  }

  @override
  List<String> getDatasources() {
    return ["Сайт РГЭУ(РИНХ)"];
  }

  @override
  void setDatasource(String name) {
    switch (name) {
      case "Сайт РГЭУ(РИНХ)":
        datasource = ScheduleOfficalDatasource();
        break;
      default:
        throw const RepositoryError(name: "Некорректный источник данных");
    }
  }
}
