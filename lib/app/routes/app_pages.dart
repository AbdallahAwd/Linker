import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:linker/app/modules/add/binding/binding.dart';
import 'package:linker/app/modules/home/views/home_view.dart';
import 'package:linker/app/modules/home/views/private_screen.dart';
import 'package:linker/app/modules/on_boarding/binding/binding.dart';
import 'package:linker/app/modules/on_boarding/views/on_boarding.dart';
import 'package:linker/app/modules/search/binding/search_binding.dart';
import 'package:linker/app/modules/search/view/view.dart';

import '../modules/home/binding/binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
        name: Paths.ONBOARDING,
        transition: Transition.rightToLeft,
        binding: OnBoardingBinding(),
        page: () => OnBoarding(),
        curve: Curves.fastOutSlowIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.rightToLeft,
        curve: Curves.fastOutSlowIn,
        transitionDuration: const Duration(milliseconds: 500)),
    // GetPage(
    //     name: Paths.ADD,
    //     page: () => AddView(),
    //     binding: AddBinding(),
    //     transition: ScaleTransition4(),
    //     curve: Curves.fastOutSlowIn,
    //     transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Paths.PRIVATE,
        page: () => const PrivateScreen(),
        binding: AddBinding(),
        transition: Transition.rightToLeft,
        curve: Curves.fastOutSlowIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
      name: Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
