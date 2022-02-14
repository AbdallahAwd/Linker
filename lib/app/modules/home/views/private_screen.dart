import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linker/app/modules/home/views/links.dart';

import '../../add/controller/add_controller.dart';

class PrivateScreen extends GetView<AddController> {
  const PrivateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Private'.tr,
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
      ),
      body: Obx(() {
        if (controller.privateList.isNotEmpty) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => linkerBuilder(
                  controller.privateList[index], index, 3, context),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: controller.privateList.length);
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
                    image: AssetImage('assets/lock.png')),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'No-Private'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
