import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxInt pageIndex = 2.obs;

  void bottomNavigateTrigger(int index) {
    this.pageIndex = RxInt(index);
    update();
  }
}
