import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/data/repositories/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryRsueOfficalImpl implements ScheduleRepository {
  ScheduleRepositoryRsueOfficalImpl(this.datasources);
  Group? group;
  GroupId? groupId;
  Map<String, ScheduleDatasource> datasources;

  ScheduleDatasource? datasource;
  Response<ScheduleService> service =
      const Response(status: ResponseStatus.init);

  @override
  Future<DataState<Map<int, String>>> getCoursesByFacultId(int faculty) async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    try {
      return DataSuccess(data: await datasource!.getCourses(faculty));
    } catch (e) {
      if (e is RsError) {
        return DataFailed(error: e);
      } else {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения данных"));
      }
    }
  }

  @override
  Future<DataState<Map<int, String>>> getFacults() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    try {
      return DataSuccess(data: await datasource!.getFacults());
    } catch (e) {
      if (e is RsError) {
        return DataFailed(error: e);
      } else {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения данных"));
      }
    }
  }

  @override
  Future<DataState<List<Group>>> getGroups() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    try {
      return DataSuccess(data: await datasource!.getAllGroups());
    } catch (e) {
      if (e is RsError) {
        return DataFailed(error: e);
      } else {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения данных"));
      }
    }
  }

  @override
  Future<DataState<Map<int, String>>> getGroupsByFacultIdAndCourseId(
      int faculty, int course) async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    try {
      return DataSuccess(data: await datasource!.getGroups(faculty, course));
    } catch (e) {
      if (e is RsError) {
        return DataFailed(error: e);
      } else {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения данных"));
      }
    }
  }

  @override
  Future<DataState<List<ConcreteLesson>>> getLessonsOnDay(DateTime date) async {
    if (service.status == ResponseStatus.done) {
      if (service.content == null) {
        return const DataFailed(
            error: RepositoryError(
                name:
                    "ЕБАНЫЙ ТВОЙ РОТ, КАКОГО ХУЯ ОНИ В ДРУГОМ ПОРЯДКЕ РАСПОЛОЖЕНЫ!!!"));
      }
      try {
        return DataSuccess(data: service.content!.getLessonsOnDay(date));
      } catch (e) {
        if (e is RsError) {
          return DataFailed(error: e);
        } else {
          return const DataFailed(
              error: RepositoryError(name: "Ошибка получения данных"));
        }
      }
    }
    return const DataFailed(
        error: RepositoryError(name: "Группа не выбрана/Сервис не создан"));
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
    return datasources.keys.toList();
  }

  @override
  void setDatasource(String name) {
    datasource = datasources[name];
  }
}
