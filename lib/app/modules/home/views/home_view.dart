import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linker/app/routes/app_pages.dart';
import 'package:linker/app/themes/colors.dart';

import '../../../ads/banner_ad.dart';
import '../../../ads/save_ad.dart';
import '../../../components/component.dart';
import '../../../data/authApi/auth.dart';
import '../../../themes/my_flutter_app_icons.dart';
import '../controllers/home_controller.dart';

// ignore: use_key_in_widget_constructors
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.appBarTitle[controller.navIndex.value].tr,
            style: const TextStyle(
              fontFamily: 'Candara',
              fontSize: 20,
              letterSpacing: 1.7,
              fontWeight: FontWeight.w700,
              height: 0.8,
            ),
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
          titleSpacing: 15,
          actions: [
            if (controller.navIndex.value == 0)
              IconButton(
                onPressed: () {
                  Get.toNamed(Paths.SEARCH);
                },
                icon: const Icon(MyFlutterApp.search),
              ),
          ],
        ),
        body: controller.screens[controller.navIndex.value],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingNavbar(
                  backgroundColor: mainColor,
                  onTap: (int val) async {
                    controller.navIndex.value = val;
                    if (val == 2) {
                      final isAuthed = await LocalAuthApi.authenticate();
                      if (isAuthed) {
                        Get.toNamed(Paths.PRIVATE);
                        await Future.delayed(Duration(seconds: 1));
                        controller.navIndex.value = 0;
                      } else {
                        Get.snackbar(
                          'Error'.tr,
                          'Auth-Error'.tr,
                          backgroundColor: Colors.red,
                        );
                        controller.navIndex.value = 0;
                      }
                    }
                  },
                  currentIndex: controller.navIndex.value,
                  items: [
                    FloatingNavbarItem(
                        icon: MyFlutterApp.linker, title: 'Links'.tr),
                    FloatingNavbarItem(
                        icon: Icons.favorite_border, title: 'Favorites'.tr),
                    FloatingNavbarItem(
                        icon: Icons.lock_outline, title: 'Private'.tr),
                    FloatingNavbarItem(
                        icon: Icons.settings, title: 'Settings'.tr),
                  ],
                ),
                const BoxAd(),
              ],
            ),
          ),
        ),
        floatingActionButton: controller.navIndex.value == 3
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.45)
                            : Colors.black),
                    borderRadius: BorderRadius.circular(50)),
                child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Paths.ADD);
                      SaveAd.loadSaveAd();
                    },
                    elevation: 50,
                    child: animateIcon(
                      context,
                      icon: Icons.add,
                    )),
              ),
      ),
    );
  }
}
