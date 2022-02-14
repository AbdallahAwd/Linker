import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add/controller/add_controller.dart';

class Private extends GetView<AddController> {
  const Private({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Authentication'.tr,
      style: const TextStyle(fontSize: 30),
    ));
  }
}
