import 'package:dio/dio.dart';
import 'package:rsue_app/src/core/error/error.dart';

abstract class DataState<T> {
  final T? data;
  final RsError? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({required super.data});
}

class DataRestored<T> extends DataState<T> {
  const DataRestored({required super.data});
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({required super.error});
}
