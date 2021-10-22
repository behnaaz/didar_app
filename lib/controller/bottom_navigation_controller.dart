import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt pageIndex = 2.obs;

  void bottomNavigateTrigger(int index) {
    this.pageIndex = RxInt(index);
    update();
  }
}
