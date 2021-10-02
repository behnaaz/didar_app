import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/model/status_item_model.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// TODO  this is temp
  bool home2 = false;

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
            home2
                ? Column(
                    children: [
                      Text('جلسات قابل ارائه خود را ثبت کنید', style: MyTextStyle.base.copyWith(fontWeight: FontWeight.bold)),
                      Image.asset(
                        AssetImages.sessionPlaceholder,
                        width: widthOfScreen - 150,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(routeSessions); // TODO  bad way to doing that
                          print('session clicked');
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
                  )
                : HomeEventDetails(),
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
//              This will render when user Event details is not empty
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class HomeEventDetails extends StatelessWidget {
  final List<StatusItemModel> _statusList = [
    StatusItemModel(title: 'درآمد ماه آینده', badgeAddress: AssetImages.badgeDidarCoin, status: '80', statusIcon: false),
    StatusItemModel(title: 'رضایت مشتری', badgeAddress: AssetImages.badgeRate, status: '3', statusIcon: true),
    StatusItemModel(title: 'فروش ماه گذشته', badgeAddress: AssetImages.badgeDidarCoin, status: '0', statusIcon: false),
    StatusItemModel(title: 'تعداد مشتری تا امروز', badgeAddress: AssetImages.badgeStudent, status: '2', statusIcon: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [SizedBox(height: 4,),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                _statusList.length,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorPallet.grayBg),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _statusList[index].statusIcon
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                          5,
                                          (i) => Icon(
                                                Icons.star,
                                                size: 14,
                                                color: int.parse(_statusList[index].status) >= i + 1 ? Colors.grey : Colors.amber,
                                              )),
                                    )
                                  : Text(_statusList[index].status),
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                _statusList[index].badgeAddress,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          _statusList[index].title,
                          style: MyTextStyle.xSmall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'جلسات آنلاین پیش رو',
              style: MyTextStyle.large.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),Container(color: Colors.blueAccent,height: 180,),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(routeSessions); // TODO  bad way to doing that
                print('session clicked');
              },
              child: Text(
                'ورود به جلسه',
                style: MyTextStyle.base.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
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
          ]),
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