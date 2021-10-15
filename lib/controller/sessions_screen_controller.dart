import 'package:get/get.dart';

class SessionsController extends GetxController {
  RxInt sessionIndexToModify = 0.obs;
  RxBool addNewSession = false.obs ; 
  RxBool modifySession = false.obs ; 
  void activeIndexToModify(int index) {
    this.sessionIndexToModify = RxInt(index);
    update();
  }
  void activeAddNew(){
     
  }
  void activeModify(){

  }
}
