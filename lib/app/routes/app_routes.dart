// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const ONBOARDING = Paths.ONBOARDING;
}

abstract class Paths {
  Paths._();
  static const HOME = '/home';
  static const ADD = '/add';
  static const SEARCH = '/search';
  static const PRIVATE = '/private';
  static const ONBOARDING = '/onboarding';
}
