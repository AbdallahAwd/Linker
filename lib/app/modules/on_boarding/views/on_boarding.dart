// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:linker/app/components/wavy_text_animations.dart';
import 'package:linker/app/modules/on_boarding/controller/on_boardding.dart';
import 'package:linker/app/modules/on_boarding/views/buildpage.dart';
import 'package:linker/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  OnBoardingController controller = Get.put(OnBoardingController());

  Tween<Offset> _scaleTween =
      Tween<Offset>(begin: Offset.zero, end: Offset.fromDirection(30, 30));

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Obx(
      () => Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              onPageChanged: (index) {
                controller.changeNum(index);
              },
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              children: [
                BuildPage(
                  imageAsset: 'assets/1.png',
                  text: 'welcome-text'.tr,
                  index: 0,
                ),
                BuildPage(
                  imageAsset: 'assets/2.png',
                  text: 'welcome-text2'.tr,
                  index: 1,
                ),
                BuildPage(
                  imageAsset: 'assets/3.png',
                  text: 'welcome-text3'.tr,
                  index: 2,
                ),
              ],
            ),
          ),
          bottomSheet: controller.index.value == 2
              ? TweenAnimationBuilder(
                  tween: _scaleTween,
                  duration: const Duration(milliseconds: 600),
                  builder: (context, Offset scale, child) {
                    return Transform.translate(
                      offset: scale,
                      // angle: scale,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                          child: GetBuilder<OnBoardingController>(
                        builder: (controller) => Container(
                          width: controller.isTaped ? 70 : double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  controller.isTaped ? 150 : 10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ElevatedButton(
                            child: controller.isTaped
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : WavyText(
                                    fontSize: 16, text: 'Get-Started'.tr),
                            onPressed: () async {
                              controller.changeTap();
                              await controller.googleLogIn();
                              Future.delayed(const Duration(seconds: 1));
                              controller.addUserData();
                              controller.uid != null
                                  ? Get.offAllNamed(Paths.HOME)
                                  : null;
                            },
                          ),
                        ),
                      )),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            pageController.animateToPage(3,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text('SKIP'.tr)),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const WormEffect(
                          spacing: 15,
                        ),
                        onDotClicked: (index) {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                      ElevatedButton(
                        child: Text('NEXT'.tr),
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                        },
                      ),
                    ],
                  ),
                )),
    );
  }
}
