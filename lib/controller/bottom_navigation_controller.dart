import 'package:get/get.dart';

enum HintStages { CalHintHowAddAvailability, CalHowModifyAvailability, SessionHint, NoHint }

class BottomNavigationController extends GetxController {
  RxInt pageIndex = 2.obs;
  RxBool hint = false.obs;
  Rx<HintStages> hintStage = HintStages.NoHint.obs;
  void bottomNavigateTrigger(int index) {
    this.pageIndex = RxInt(index);
    update();
  }

  void toggleHint() {
    this.hint.toggle();
    update();
  }

  void CheckHintStage(HintStages stage) {
    switch (stage) {
      case HintStages.CalHintHowAddAvailability:
        this.hintStage = Rx(HintStages.CalHintHowAddAvailability);
        this.pageIndex = RxInt(3);
        update();
        break;
      case HintStages.SessionHint:
        this.hintStage = Rx(HintStages.SessionHint);
        this.pageIndex = RxInt(1);
        update();
        break;

      case HintStages.CalHowModifyAvailability:
        this.hintStage = Rx(HintStages.CalHowModifyAvailability);
        this.pageIndex = RxInt(3);
        update();

        break;
      case HintStages.NoHint:
        this.hintStage = Rx(HintStages.NoHint);
        update();
        break;
    }
  }
}
