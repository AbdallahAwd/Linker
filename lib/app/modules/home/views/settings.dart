import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linker/app/modules/on_boarding/controller/on_boardding.dart';
import 'package:linker/app/routes/app_pages.dart';
import 'package:linker/app/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/component.dart';
import '../controllers/home_controller.dart';
import '../../../components/slide_animation.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({Key? key}) : super(key: key);

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  OnBoardingController controller = Get.put(OnBoardingController());
  HomeController homeController = Get.put(HomeController());

  int colorIndex = 0;

  @override
  void initState() {
    homeController.storage.read('CurrentTheme');
    homeController.storage.read('language');

    super.initState();
  }

  void changeColor(int indez) {
    setState(() {
      colorIndex = indez;
      indez == 0 ? isSecondColor = false : isSecondColor = true;
      GetStorage().write('isSecondColor', isSecondColor);
    });
    // GetStorage().read('isSecondColor') ? secondColor:mainColor;
  }

  changeIndex() {
    setState(() {});
  }

  String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textUtil(text: 'Account'.tr),
          const SizedBox(
            height: 25,
          ),
          SlideFadeTransition(
            curve: Curves.elasticOut,
            // delayStart: const Duration(milliseconds: 500),
            animationDuration: const Duration(milliseconds: 1200),
            offset: 1.25,
            direction: Direction.vertical,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: isSecondColor ? secondColor : mainColor,
                  radius: 45,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      homeController.userModel!.image!,
                      errorBuilder: ((context, error, stackTrace) => const Icon(
                            Icons.info,
                            size: 90,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    textUtil(text: homeController.userModel!.userName!),
                    const SizedBox(
                      height: 30,
                    ),
                    textUtil(text: homeController.userModel!.email!),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          textUtil(text: 'General'.tr),
          SlideFadeTransition(
            curve: Curves.elasticOut,
            delayStart: const Duration(milliseconds: 500),
            animationDuration: const Duration(milliseconds: 1000),
            offset: 2.5,
            direction: Direction.vertical,
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text('App-Theme'.tr),
              onTap: () {
                Get.defaultDialog(
                    title: 'App-Theme'.tr,
                    content: GetBuilder<HomeController>(builder: (controller) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text('Follow-System'.tr),
                            leading: Radio<Themess>(
                              value: Themess.FollowSystem,
                              activeColor: GetStorage().read('isSecondColor')
                                  ? secondColor
                                  : mainColor,
                              groupValue: homeController.theme,
                              onChanged: (Themess? value) {
                                homeController.changeTheme(value!);
                                Get.changeThemeMode(ThemeMode.system);
                                homeController.storage.write(
                                    'isDark', homeController.darkMode[0]);
                                Get.back();
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('Dark'.tr),
                            leading: Radio<Themess>(
                              value: Themess.DarkMode,
                              activeColor: GetStorage().read('isSecondColor')
                                  ? secondColor
                                  : mainColor,
                              groupValue: homeController.theme,
                              onChanged: (Themess? value) {
                                homeController.changeTheme(value!);
                                Get.changeThemeMode(ThemeMode.dark);
                                homeController.storage.write(
                                    'isDark', homeController.darkMode[1]);
                                Get.back();
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('Light'.tr),
                            leading: Radio<Themess>(
                              activeColor: GetStorage().read('isSecondColor')
                                  ? secondColor
                                  : mainColor,
                              value: Themess.LightMode,
                              groupValue: homeController.theme,
                              onChanged: (Themess? value) {
                                homeController.changeTheme(value!);
                                Get.changeThemeMode(ThemeMode.light);
                                homeController.storage.write(
                                    'isDark', homeController.darkMode[2]);
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      );
                    }));
              },
            ),
          ),
          SlideFadeTransition(
              curve: Curves.elasticOut,
              delayStart: const Duration(milliseconds: 500),
              animationDuration: const Duration(milliseconds: 1200),
              offset: 2.5,
              direction: Direction.vertical,
              child: ListTile(
                leading: const Icon(Icons.color_lens),
                title: Text('Themes'.tr),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<HomeController>(
                      builder: (homeController) => SizedBox(
                        height: 50,
                        width: 120,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // bool isColor = false;
                            return InkWell(
                              onTap: () {
                                changeColor(index);
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorIndex == index
                                            ? Colors.grey
                                            : Colors.transparent,
                                        width: 2),
                                    color: index == 0 ? mainColor : secondColor,
                                    shape: BoxShape.circle),
                              ),
                            );
                          },
                          itemCount: 2,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          SlideFadeTransition(
            curve: Curves.elasticOut,
            delayStart: const Duration(milliseconds: 1000),
            animationDuration: const Duration(milliseconds: 1200),
            offset: 2.5,
            direction: Direction.vertical,
            child: ListTile(
              leading: const Icon(Icons.language_outlined),
              title: Text('Language'.tr),
              trailing: DropdownButtonHideUnderline(
                child: Container(
                  width: 110,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButton<String>(
                    // value: value ?? 'Lang',
                    hint: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Language'.tr),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text('العربيه'),
                        value: 'ar_EG',
                      ),
                      DropdownMenuItem(
                        child: Text('English'),
                        value: 'en_US',
                      ),
                      DropdownMenuItem(
                        child: Text('española'),
                        value: 'es_ES',
                      ),
                    ],
                    onChanged: (String? val) {
                      setState(() {
                        value = val!;
                      });
                      homeController.storage.write('language', value);
                      if (value == 'ar_EG') {
                        Get.updateLocale(const Locale('ar', 'EG'));
                      } else if (value == 'en_US') {
                        Get.updateLocale(const Locale('en', 'US'));
                      } else {
                        Get.updateLocale(const Locale('es', 'US'));
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SlideFadeTransition(
            curve: Curves.elasticOut,
            delayStart: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 1200),
            offset: 2.25,
            direction: Direction.vertical,
            child: ListTile(
              leading: const Icon(Icons.star),
              title: Text('rate'.tr),
              onTap: () async {
                if (await canLaunch(
                    'https://play.google.com/store/apps/details?id=com.ama.linker')) {
                  await launch(
                      'https://play.google.com/store/apps/details?id=com.ama.linker');
                }
              },
            ),
          ),
          SlideFadeTransition(
            curve: Curves.elasticOut,
            delayStart: const Duration(milliseconds: 2000),
            animationDuration: const Duration(milliseconds: 1200),
            offset: 2.25,
            direction: Direction.vertical,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Log-Out'.tr),
              onTap: () async {
                Get.offAllNamed(Paths.ONBOARDING);
                controller.storage.remove('uId');
                controller.logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget textUtil({text}) {
  return SizedBox(
    width: 200,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Candara',
        fontSize: 15,
        color: isSecondColor ? secondColor : mainColor,
        letterSpacing: 1.335,
        fontWeight: FontWeight.w700,
        height: 1.0666666666666667,
      ),
      overflow: TextOverflow.ellipsis,
      textHeightBehavior:
          const TextHeightBehavior(applyHeightToFirstAscent: false),
      softWrap: false,
    ),
  );
}
