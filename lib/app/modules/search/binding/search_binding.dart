import 'package:get/instance_manager.dart';

import '../controller/seach_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
