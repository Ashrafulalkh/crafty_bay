import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_Controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
  }

}