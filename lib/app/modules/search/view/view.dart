import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linker/app/modules/search/controller/seach_controller.dart';
import 'package:linker/app/themes/colors.dart';
import 'package:linker/app/themes/my_flutter_app_icons.dart';

import '../../home/views/links.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(MyFlutterApp.search),
        title: SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller.searchController,
            decoration: InputDecoration(
                hintText: 'Search-Hint'.tr,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.highlight_remove_sharp,
                    color: GetStorage().read('isSecondColor')
                        ? secondColor
                        : mainColor,
                  ),
                  onPressed: () => controller.clear(),
                )),
            onChanged: (val) {
              val != '' ? controller.search(val) : null;
            },
          ),
        ),
      ),
      body: Obx(() {
        if (controller.searchList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return linkerBuilder(
                      controller.searchList[index], index, 4, context);
                },
                itemCount: controller.searchList.length),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_outlined,
                  size: 120,
                  color: isSecondColor ? secondColor : mainColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Result'.tr,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
