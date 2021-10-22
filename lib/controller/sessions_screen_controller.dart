import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionsController extends GetxController {
  RxInt sessionIndexToModify = 0.obs;

  // session form field --::--::--::--::--::--::--::--::--::--::--::--::--::--::
  RxString dropDownCategory = ''.obs;
  RxString dropDownAudience = ''.obs;
  RxString dropDownTimeDuration = ''.obs;
  RxString dropDownNumOfSession = ''.obs;
  RxString dropDownCapacity = ''.obs;

  TextEditingController priceController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  RxInt? selectedColorIndex;
  // --::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--:

  RxMap session = {}.obs;
  void activeIndexToModify(int index, Map session) {
    this.sessionIndexToModify = RxInt(index);
    this.session = RxMap(session);
    _updateFormFieldForModify();
    update();
    print(this.session);
  }

  void _updateFormFieldForModify() {
    dropDownCategory = RxString(this.session['session_type']);
    dropDownAudience = RxString(this.session['audience']);
    dropDownTimeDuration = RxString(this.session['duration']);
    dropDownNumOfSession = RxString(this.session['session_num']);
    dropDownCapacity = RxString(this.session['capacity']);
    priceController.text = this.session['price'];
    infoController.text = this.session['info'];
    selectedColorIndex = RxInt(int.parse(session['color']));
  }

   void emptyTheFields() {
    dropDownCategory = RxString('');
    dropDownAudience = RxString('');
    dropDownTimeDuration = RxString('');
    dropDownNumOfSession = RxString('');
    dropDownCapacity = RxString('');
    priceController.text = '';
    infoController.text = '';
    selectedColorIndex = null;
    
  }
}
