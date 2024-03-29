import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/data/repositories/repository_template.dart';
import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryRsueOfficalImpl extends RepositoryBase implements ScheduleRepository {
  ScheduleRepositoryRsueOfficalImpl(this.datasources);
  Group? group;
  GroupId? groupId;
  Map<String, (ScheduleDatasource, ScheduleLocalDatasource)> datasources;

  DsNameStorage dsNameStorage = DsNameStorage();

  ScheduleDatasource? datasource;
  ScheduleLocalDatasource? cacheDatasource;

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
    return invokeDSs(
        ()=>datasource!.getCourses(faculty),
        ()=>cacheDatasource!.getCourses(faculty),
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
    var ins = await invokeDSs(
        ()=>datasource!.getFacults(),
        ()=>cacheDatasource!.getFacults(),
        (snapshot) => cacheDatasource!.setFacults(snapshot),
        "ошибка кэша",
        "ошибка интернета");
    return ins;
  }

  @override
  Future<DataState<List<Group>>> getGroups() async {
    if (datasource == null) {
      return const DataFailed(
          error: RepositoryError(name: "Источник не выбран"));
    }
    return invokeDSs(
        ()=>datasource!.getAllGroups(),
        ()=>cacheDatasource!.getAllGroups(),
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
    return invokeDSs(
        ()=>datasource!.getGroups(faculty, course),
        ()=>cacheDatasource!.getGroups(faculty, course),
        (snapshot) => cacheDatasource!.setGroups(snapshot, faculty, course),
        "ошибка кэша",
        "ошибка интернета");
  }

  @override
  void setGroup(Group group) {
    this.group = group;
    groupId = group.id;
    cacheDatasource!.setLastGroup(groupId);
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
    return invokeDSs(
        ()=>datasource!.getScheduleService((groupId ?? group?.id)!),
        ()=>cacheDatasource!.getScheduleService((groupId ?? group?.id)!),
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
