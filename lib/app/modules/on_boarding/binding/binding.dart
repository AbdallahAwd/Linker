import 'package:get/instance_manager.dart';
import 'package:linker/app/modules/on_boarding/controller/on_boardding.dart';

class OnBoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController());
  }
}
