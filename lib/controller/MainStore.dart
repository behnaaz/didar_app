import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxString userUid = ''.obs;

  void increment(uid) => this.userUid = uid;
}
