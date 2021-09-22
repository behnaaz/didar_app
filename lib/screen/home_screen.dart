import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthenticationService>(context);
    double widthOfScreen = MediaQuery.of(context).size.width;
    print(widthOfScreen);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: widthOfScreen,
                  child: Stack(
                    children: [
                      // for majoring the height of pic
                      Opacity(
                        opacity: 0,
                        child: Image.asset(
                          AssetImages.homeHeader,
                        ),
                      ),
                      Positioned(
                        width: widthOfScreen,
                        child: Image.asset(
                          AssetImages.homeHeader,
                        ),
                      ),
                      Positioned(
                          top: 46 * ((widthOfScreen) / 411),
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'جمعه 1 مرداد ماه 1400 | 2021 Friday 21 July',
                                style: MyTextStyle.base.copyWith(color: Colors.white),
                              )))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('جلسات قابل ارائه خود را ثبت کنید', style: MyTextStyle.base.copyWith(fontWeight: FontWeight.bold)),
                Image.asset(
                  AssetImages.sessionPlaceholder,
                  width: widthOfScreen - 150,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(routeSessions);
              
                  },
                  child: Text('ثبت جلسه'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => ColorPallet.red),
                    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(38), border: Border.all(color: ColorPallet.blue)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  quickAccess(title: 'مشخصات جلسات', icon: Image.asset(AssetImages.iconSessionSetting)),
                  quickAccess(title: 'تقویم کاری', icon: Image.asset(AssetImages.iconWorkCalendar)),
                  quickAccess(title: 'ثبت جلسات', icon: Image.asset(AssetImages.iconAddSession)),
                  quickAccess(title: 'بازاریابی', icon: Image.asset(AssetImages.iconRevenue)),
                  quickAccess(title: 'آموزش مالی', icon: Image.asset(AssetImages.iconFinancialStuff)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                      Quick Access Item
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Expanded quickAccess({
  required String title,
  required Widget icon,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(width: 30, child: icon),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              title,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
// _____________________________________________________________________________