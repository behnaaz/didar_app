import 'package:didar_app/model/session_model.dart';
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

  Rx<SessionModel>? session;
  void activeIndexToModify(int index, SessionModel session) {
    this.sessionIndexToModify = RxInt(index);
    this.session = Rx<SessionModel>(session);
    _updateFormFieldForModify();
    update();
    print(this.session);
  }

  void _updateFormFieldForModify() {
    dropDownCategory = RxString(this.session!.value.type);
    dropDownAudience = RxString(this.session!.value.audience);
    dropDownTimeDuration = RxString(this.session!.value.durationTime);
    dropDownNumOfSession = RxString(this.session!.value.numOfSessions);
    dropDownCapacity = RxString(this.session!.value.capacity);
    priceController.text = this.session!.value.price;
    infoController.text = this.session!.value.info;
    selectedColorIndex = RxInt(int.parse(this.session!.value.color));
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
