import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linker/app/modules/add/controller/add_controller.dart';
import 'package:linker/app/modules/home/views/links.dart';

class Favorites extends GetView<AddController> {
  // ignore: prefer_const_constructors_in_immutables
  Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddController());

    return Obx(() {
      if (controller.favoriteList.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => linkerBuilder(
                  controller.favoriteList[index], index, 2, context),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: controller.favoriteList.length),
        );
      } else {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  width: 400,
                  height: 200,
                  image: AssetImage('assets/heart.png')),
              const SizedBox(
                height: 20,
              ),
              Text(
                'No-Favorite'.tr,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
