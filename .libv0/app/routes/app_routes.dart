part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SELECTGROUP = '/selectgroup';
  static const RSUELOGIN = '/rsuelogin';
}
