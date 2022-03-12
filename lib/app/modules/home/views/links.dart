// ignore_for_file: prefer_final_fields
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:linker/app/ads/save_ad.dart';
import 'package:linker/app/components/component.dart';
import 'package:linker/app/modules/add/models/model.dart';
import 'package:linker/app/modules/add/view/add.dart';
import 'package:linker/app/modules/home/controllers/home_controller.dart';
import 'package:linker/app/modules/home/views/search_icons.dart';
import 'package:linker/app/modules/search/controller/seach_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../themes/colors.dart';
import '../../../themes/my_flutter_app_icons.dart';
import '../../add/controller/add_controller.dart';

class Links extends GetView<HomeController> {
  const Links({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.linkList.isEmpty) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Search.link,
                size: 100,
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'No-Links'.tr,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      } else {
        double w = MediaQuery.of(context).size.width;
        return GetBuilder<HomeController>(
          builder: (contoller) => AnimationLimiter(
            child: ListView.builder(
                padding: EdgeInsets.all(w / 40),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) => linkerBuilder(
                    controller.linkList[index], index, 1, context),
                itemCount: controller.linkList.length),
          ),
        );
      }
    });
  }
}

Widget linkerBuilder(
  AddLinkModel model,
  index,
  int num,
  context,
) {
  HomeController controller = Get.put(HomeController());
  AddController addController = Get.put(AddController());
  SearchController searchController = Get.put(SearchController());
  Key disKey() {
    if (num == 1) {
      return Key(controller.itemId[index]);
    } else if (num == 2) {
      return Key(addController.favoriteItem[index]);
    } else if (num == 3) {
      return Key(addController.privateItem[index]);
    } else {
      return Key(searchController.searchListId[index]);
    }
  }

  double width = MediaQuery.of(context).size.width;
  return Dismissible(
    key: disKey(),
    onDismissed: (dirction) {
      HapticFeedback.heavyImpact();
      if (num == 1) {
        controller.deleteItem(controller.itemId[index]);
      } else if (num == 2) {
        addController.favDelete(addController.favoriteItem[index]);
      } else if (num == 3) {
        addController.privDelete(addController.privateItem[index]);
      } else {
        searchController.searchDelete(searchController.searchListId[index]);
      }
    },
    child: AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: ScaleAnimation(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: InkWell(
            onTap: () {
              _launchURL(model.url);
            },
            onLongPress: () {
              FlutterClipboard.copy(model.url!);
              HapticFeedback.heavyImpact();
              toast(text: 'Copied');
            },
            child: Container(
              height: 95,
              margin: EdgeInsets.only(bottom: width / 20),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: width / 2,
                                child: AutoSizeText(
                                  model.title!,
                                  style: TextStyle(
                                    fontFamily: 'Candara',
                                    fontSize: 20,
                                    color: Colors.white.withOpacity(0.8),
                                    letterSpacing: 1.7799999999999998,
                                    fontWeight: FontWeight.w700,
                                    height: 0.8,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                width: width / 2,
                                child: AutoSizeText(
                                  model.url!,
                                  style: TextStyle(
                                    fontFamily: 'Candara',
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.8),
                                    letterSpacing: 1.7799999999999998,
                                    fontWeight: FontWeight.w700,
                                    height: 0.8,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                )),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            _launchURL(model.url);
                          },
                          icon: const Icon(MyFlutterApp.launch),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: num == 1 ? 10.0 : 25.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                AddController c = Get.put(AddController());
                                if (num == 1) {
                                  controller
                                      .deleteItem(controller.itemId[index]);
                                } else if (num == 2) {
                                  HapticFeedback.lightImpact();
                                  c.favDelete(c.favoriteItem[index]);
                                } else if (num == 3) {
                                  HapticFeedback.lightImpact();
                                  c.privDelete(c.privateItem[index]);
                                } else {
                                  SearchController controller =
                                      Get.put(SearchController());
                                  HapticFeedback.lightImpact();
                                  controller.searchDelete(
                                      controller.searchListId[index]);
                                }

                                // addController
                                //     .favDelete(addController.favoriteItem[index]);
                              },
                              child: animatedUnder(
                                  icon: Icons.delete_outline_outlined,
                                  text: 'Delete'.tr),
                            ),
                            const Spacer(),
                            num == 1
                                ? InkWell(
                                    onTap: () {
                                      Get.lazyPut(() => AddController());
                                      HapticFeedback.lightImpact();

                                      Get.to(
                                        AddView(
                                            title: model.title,
                                            isFav: model.isFavorite,
                                            isPriv: model.isPrivate,
                                            url: model.url,
                                            index: index,
                                            appSave: 'UPDATE'.tr,
                                            appTitle: 'Update-Link'.tr),
                                      );
                                      SaveAd.loadSaveAd();
                                    },
                                    child: animatedUnder(
                                        icon: Icons.edit, text: 'Edit'.tr))
                                : const SizedBox(),
                            num == 1 ? const Spacer() : const SizedBox(),
                            InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Share.share(
                                      '${model.title} \n ${model.url!}');
                                },
                                child: animatedUnder(
                                    icon: Icons.share, text: 'Share'.tr)),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  HapticFeedback.heavyImpact();

                                  FlutterClipboard.copy(model.url!);
                                  toast(text: 'Copied'.tr);
                                },
                                child: animatedUnder(
                                    icon: Icons.copy, text: 'Copy'.tr)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

Widget underText(text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Candara',
      fontSize: 15,
      color: Colors.white.withOpacity(0.8),
      letterSpacing: 1.335,
      fontWeight: FontWeight.w700,
      height: 1.6,
    ),
    textHeightBehavior:
        const TextHeightBehavior(applyHeightToFirstAscent: false),
    textAlign: TextAlign.center,
    softWrap: false,
  );
}

Widget animatedUnder({
  required icon,
  required text,
}) =>
    Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        underText(
          text,
        ),
      ],
    );
