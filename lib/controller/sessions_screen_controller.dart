import 'package:get/get.dart';

class SessionsController extends GetxController {
  RxInt sessionIndexToModify = 0.obs;
  Map session = {};
  void activeIndexToModify(int index , Map session) {
    this.sessionIndexToModify = RxInt(index);
    this.session = session;
    update();
    print(this.session);
  }
}
