import 'package:get/instance_manager.dart';
import 'package:linker/app/modules/add/controller/add_controller.dart';

class AddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddController());
  }
}
