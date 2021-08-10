import 'package:get/get.dart';

class Controller extends GetxController {
  RxString userUid = ''.obs;

  void increment(uid) => this.userUid = uid;
}
