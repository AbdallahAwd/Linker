// ignore_for_file: prefer_final_fields, must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linker/app/components/component.dart';
import 'package:linker/app/modules/add/controller/add_controller.dart';
import 'package:linker/app/modules/home/controllers/home_controller.dart';
import 'package:linker/app/themes/colors.dart';
import 'package:linker/app/themes/my_flutter_app_icons.dart';

import '../../../ads/save_ad.dart';

class AddView extends GetView<AddController> {
  var index;
  var title;
  var url;
  var appTitle;
  var appSave;
  bool? isFav = false;
  bool? isPriv = false;
  AddView(
      {this.index,
      this.title,
      this.url,
      this.appTitle,
      this.appSave,
      this.isFav,
      this.isPriv});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    controller.titleController.text = title ?? '';
    controller.urlController.text = url ?? '';
    controller.favoriteCheck = isFav ?? false;
    controller.privateCheck = isPriv ?? false;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.85),
      child: Scaffold(
        appBar:
            AppBar(title: mainText(context, text: appTitle ?? 'Add-Link'.tr)),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Container(
              decoration: BoxDecoration(
                color: const Color(0x006200ee),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      defaultTextFormFeild(
                          controller: controller.titleController,
                          pre: MyFlutterApp.title,
                          hintText: 'Title'.tr,
                          suff: Icons.highlight_remove_rounded,
                          suffPress: () {
                            controller.titleController.clear();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Validation'.tr;
                            }
                            return null;
                          },
                          keyType: TextInputType.text),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultTextFormFeild(
                          controller: controller.urlController,
                          pre: MyFlutterApp.linker,
                          hintText: 'URL'.tr,
                          suff: Icons.highlight_remove_rounded,
                          suffPress: () {
                            controller.urlController.clear();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Validation'.tr;
                            }
                            return null;
                          },
                          keyType: TextInputType.text),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          GetBuilder<AddController>(
                            builder: (controller) => Checkbox(
                              value: controller.favoriteCheck,
                              onChanged: (val) {
                                controller.changeFavCheck(val!);
                              },
                              activeColor: mainColor,
                            ),
                          ),
                          mainText(context,
                              text: 'Add-Favorite'.tr, fontsize: 13),
                          // const Spacer(),
                          GetBuilder<AddController>(
                            builder: (controller) => Checkbox(
                                activeColor: mainColor,
                                value: controller.privateCheck,
                                onChanged: (val) {
                                  controller.changePriCheck(val!);
                                }),
                          ),
                          Expanded(
                            child: mainText(
                              context,
                              text: 'Add-Private'.tr,
                              fontsize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                controller.clear();
                                Get.back(closeOverlays: true);
                                SaveAd.showSaveAd();
                                HapticFeedback.lightImpact();
                              },
                              child: Text('Cancel'.tr)),
                          ElevatedButton(
                              child: Text(appSave ?? 'SAVE'.tr),
                              onPressed: () async {
                                HapticFeedback.lightImpact();

                                if (formKey.currentState!.validate()) {
                                  if (GetUtils.isURL(
                                          controller.urlController.text) &&
                                      controller.urlController.text
                                          .contains('https://') &&
                                      appSave == null) {
                                    if (controller.favoriteCheck) {
                                      controller.isFav();
                                    } else if (controller.privateCheck) {
                                      controller.isPrivate();
                                    } else {
                                      controller.addLink();
                                    }

                                    toast(text: 'Added'.tr);
                                    SaveAd.showSaveAd();
                                    Get.back(closeOverlays: true);
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));

                                    controller.clear();
                                  } else if (appSave == 'UPDATE'.tr &&
                                      GetUtils.isURL(
                                          controller.urlController.text) &&
                                      controller.urlController.text
                                          .contains('https://')) {
                                    controller.updateLink(
                                        homeController.itemId[index]);
                                    if (controller.favoriteCheck) {
                                      controller.isFav();
                                      homeController.deleteItem(
                                          homeController.itemId[index]);
                                    } else if (controller.privateCheck) {
                                      controller.isPrivate();
                                      homeController.deleteItem(
                                          homeController.itemId[index]);
                                    }
                                    SaveAd.showSaveAd();
                                    toast(text: 'Updated'.tr);

                                    Get.back(closeOverlays: true);
                                  } else {
                                    Get.snackbar(
                                      'Error'.tr,
                                      'invalid-Link'.tr,
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
