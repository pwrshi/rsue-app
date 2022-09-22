import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/error/response_error.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this.source);
  String? username;
  String? password;
  PortfolioDataSource? source;
  bool _checkCredits() {
    if ((username == null) || (password == null)) {
      return false;
    }
    return true;
  }

  @override
  Future<DataState<Map<String, List<SubjectEntity>>>>
      getAcademicPerfomance() async {
    if (_checkCredits()) {
      try {
        return DataSuccess(
            data: await source!.getAcademicPerfomance(username!, password!));
      } catch (e) {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения успеваемости"));
      }
    }

    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }

  @override
  Future<DataState<List<PaymentEntity>>> getPayments() async {
    if (_checkCredits()) {
      try {
        return DataSuccess(
            data: await source!.getPayments(username!, password!));
      } catch (e) {
        return const DataFailed(
            error: RepositoryError(name: "Ошибка получения платежей"));
      }
    }
    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }

  @override
  Future<DataState<void>> login(String username, String password) async {
    try {
      if (await source!.checkCredentials(username, password)) {
        this.username = username;
        this.password = password;
        return const DataSuccess(data: "");
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
      try {
        return DataSuccess(data: await source!.whoami(username!, password!));
      } catch (e) {
        return const DataFailed(
            error: RepositoryError(
                name: "Ошибка получения информации о пользователе"));
      }
    }

    return const DataFailed(error: RepositoryError(name: "вы не залогинены"));
  }
}
