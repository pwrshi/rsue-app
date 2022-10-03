import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/error/response_error.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this.source, this.cacheSource);
  String? username;
  String? password;
  PortfolioDatasource source;
  PortfolioLocalDatasource cacheSource;
  bool _checkCredits() {
    if ((username == null) || (password == null)) {
      return false;
    }
    return true;
  }

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

  @override
  Future<DataState<Map<String, List<SubjectEntity>>>>
      getAcademicPerfomance() async {
    if (_checkCredits()) {
      return await _invokeDSs(
          source.getAcademicPerfomance(username!, password!),
          cacheSource.getAcademicPerfomance(username!, password!),
          (snapshot) =>
              cacheSource.setAcademicPerfomance(username!, password!, snapshot),
          "ошибка воостановления из кэша успеваемости",
          "ошибка скачивания успеваемости");
    }
    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }

  @override
  Future<DataState<List<PaymentEntity>>> getPayments() async {
    if (_checkCredits()) {
      return await _invokeDSs(
          source.getPayments(username!, password!),
          cacheSource.getPayments(username!, password!),
          (snapshot) => cacheSource.setPayments(username!, password!, snapshot),
          "ошибка воостановления из кэша платежей",
          "ошибка скачивания платежей");
    }
    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }

  @override
  Future<DataState<void>> login(String username, String password) async {
    try {
      if (await source.checkCredentials(username, password)) {
        this.username = username;
        this.password = password;
        await cacheSource.setLastCredentials(username, password);
        return const DataSuccess(data: '');
      } else {
        return const DataFailed(error: ResponseError(name: "неправильно!!!!!"));
      }
    } catch (e) {
      return const DataFailed(error: RepositoryError(name: "Ошибка входа"));
    }
  }

  @override
  void logout() {
    username = null;
    password = null;
  }

  @override
  Future<DataState<Map<String, String>>> whoami() async {
    if (_checkCredits()) {
      return await _invokeDSs(
          source.getWhoami(username!, password!),
          cacheSource.getWhoami(username!, password!),
          (snapshot) => cacheSource.setWhoami(username!, password!, snapshot),
          "ошибка воостановления из кэша хтоя",
          "ошибка скачивания хтоя");
    }
    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }

  @override
  Future<bool> isAuthorized() async {
    if (!_checkCredits()) {
      try {
        var lp = await cacheSource.getLastCredentials();
        username = lp!.$0;
        password = lp.$1;
      } catch (e) {
        return false;
      }
    }
    return _checkCredits();
  }
}
