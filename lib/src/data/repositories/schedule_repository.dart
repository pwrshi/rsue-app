import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/error/response_error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryRsueOfficalImpl implements ScheduleRepository {
  ScheduleRepositoryRsueOfficalImpl(this.datasources);
  Group? group;
  GroupId? groupId;
  Map<String, (ScheduleDatasource, ScheduleLocalDatasource)> datasources;

  DsNameStorage dsNameStorage = DsNameStorage();

  ScheduleDatasource? datasource;
  ScheduleLocalDatasource? cacheDatasource;

  Future<DataState<T>> _invokeDSs<T>(
      Future<T?> onlineDs,
      Future<T?> localDs,
      Future<void> Function(T snapshot) saveDsCallback,
      String localErr,
      String onlineErr) async {
    DataState<T> result;

    try {
      var snapshot = await onlineDs;
      if (snapshot == null) {
        throw const RepositoryError(name: "no data");
      }
      saveDsCallback(snapshot);
      result = DataSuccess(data: snapshot);
    } catch (onlineErr) {
      if (onlineErr is RsError) {
        result = DataFailed(error: onlineErr);
      } else {
        result = DataFailed(error: RepositoryError(name: onlineErr.toString()));
      }

      // попытка взять из локального источника
      try {
        var localSnap = await localDs;
        if (localSnap == null) {
          throw const ResponseError(name: "no local data");
        }
        result = DataRestored(data: localSnap);
      } catch (localErr) {
        if (localErr is RsError) {
          result = DataFailed(error: localErr);
        } else {
          result =
              DataFailed(error: RepositoryError(name: localErr.toString()));
        }
      }
    }
    return result;
  }

  Future<bool> groupIsSetted()async{
    if (cacheDatasource == null) {
      throw const RepositoryError(name: "Источник не выбран");
    }
    var s = await cacheDatasource!.getLastGroup();
    if (s == null) {
      return false;
    }
    groupId = s;
    return true;
  }


  @override
  Future<DataState<Map<int, String>>> getCoursesByFacultId(int faculty) async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    return _invokeDSs(
        datasource!.getCourses(faculty),
        cacheDatasource!.getCourses(faculty),
        (snapshot) => cacheDatasource!.setCourses(snapshot, faculty),
        "ошибка кэша",
        "ошибка интернета");
  }

  @override
  Future<DataState<Map<int, String>>> getFacults() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    return _invokeDSs(
        datasource!.getFacults(),
        cacheDatasource!.getFacults(),
        (snapshot) => cacheDatasource!.setFacults(snapshot),
        "ошибка кэша",
        "ошибка интернета");
  }

  @override
  Future<DataState<List<Group>>> getGroups() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    return _invokeDSs(
        datasource!.getAllGroups(),
        cacheDatasource!.getAllGroups(),
        (snapshot) => cacheDatasource!.setAllGroups(snapshot),
        "ошибка кэша",
        "ошибка интернета");
  }

  @override
  Future<DataState<Map<int, String>>> getGroupsByFacultIdAndCourseId(
      int faculty, int course) async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    return _invokeDSs(
        datasource!.getGroups(faculty, course),
        cacheDatasource!.getGroups(faculty, course),
        (snapshot) => cacheDatasource!.setGroups(snapshot, faculty, course),
        "ошибка кэша",
        "ошибка интернета");
  }

  @override
  void setGroup(Group group) {
    this.group = group;
    groupId = group.id;
  }

  @override
  void setGroupByGroupId(GroupId groupId) {
    this.groupId = groupId;
    cacheDatasource!.setLastGroup(groupId);
  }

  @override
  void unsetGroup() {
    group = null;
    groupId = null;
  }

  @override
  List<String> getDatasources() {
    return datasources.keys.toList();
  }

  @override
  void setDatasource(String name) {
    datasource = datasources[name]!.$0;
    cacheDatasource = datasources[name]!.$1;
    dsNameStorage.setLastDsName(name).then((value) => null);
  }

  @override
  Future<DataState<ScheduleService>> getScheduleService() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    if ((groupId == null) && (group == null)) {
      return const DataFailed(
          error: RepositoryError(name: "группа не выставлена"));
    }
    return _invokeDSs(
        datasource!.getScheduleService((groupId ?? group?.id)!),
        cacheDatasource!.getScheduleService((groupId ?? group?.id)!),
        (snapshot) => cacheDatasource!.setScheduleService(
            (groupId ?? group?.id)!, snapshot),
        "ошибка воостановления расписания",
        "ошибка загрузки расписания");
  }
  
  @override
  Future<bool> isAuthorized() async {
    var dsname = await dsNameStorage.getLastDsName();
    if(dsname == null) {
      return false;
    }
    
    datasource = datasources[dsname]!.$0;
    cacheDatasource = datasources[dsname]!.$1;
    if (!(await groupIsSetted())) {
      return false;
    }
    return true;
  }
}
