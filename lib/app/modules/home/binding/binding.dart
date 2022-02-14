import 'package:get/instance_manager.dart';
import 'package:linker/app/modules/add/controller/add_controller.dart';
import 'package:linker/app/modules/home/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddController());
  }
}
