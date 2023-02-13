part of 'router.dart';

abstract class Routes {
  Routes._();
  static const String root = '/';
  static const String setupPin = '/setup-pin';
  static const String pinAuth = '/pin-auth';
}

extension StringExtension on String {
  String removeSlash() {
    String str = replaceAll('/', '');
    return str;
  }
}
