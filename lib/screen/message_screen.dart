import 'package:didar_app/constants/them_conf.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MessageScreen extends StatelessWidget {
  final _kTabs = <Tab>[
    Tab(
        child: Text(
      'پیام ها',
      style: MyTextStyle.large,
    )),
    Tab(
        child: Text(
      'دیدار',
      style: MyTextStyle.large,
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            AssetImages.logo,
            height: 40,
          ),
          centerTitle: true,
          bottom: TabBar(tabs: _kTabs),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TabBarView(
            children: [
             
              ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AssetImages.userEmptyAvatar,
                                width: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'دیدار',
                                    style: MyTextStyle.large.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'جلسه جدید',
                                        style: MyTextStyle.base,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'new',
                                        style: MyTextStyle.base.copyWith(backgroundColor: ColorPallet.blue, color: Colors.white, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                '1400/10/02',
                                style: MyTextStyle.small,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '...عزیز',
                                  style: MyTextStyle.base,
                                ),
                                Text(
                                  'جلسات زیر در تقویم کاری شما ثبت شد:',
                                  style: MyTextStyle.base,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'تعداد جلسات : 4',
                                  style: MyTextStyle.base,
                                ),
                                Row(
                                  children: [
                                    Text('زمان: '),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              LineIcons.check,
                                              color: ColorPallet.blue,
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'چهارشنبه 8 دی ماه ساعت 10 تا 11',
                                              style: MyTextStyle.base,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              LineIcons.check,
                                              color: ColorPallet.blue,
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'پنجشنبه 8 دی ماه ساعت 10 تا 11',
                                              style: MyTextStyle.base,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              LineIcons.check,
                                              color: ColorPallet.blue,
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'چهارشنبه 8 دی ماه ساعت 11 تا 12',
                                              style: MyTextStyle.base,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              LineIcons.check,
                                              color: ColorPallet.blue,
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'چهارشنبه 8 دی ماه ساعت 10 تا 11',
                                              style: MyTextStyle.base,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AssetImages.logo,
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'دیدار',
                                style: MyTextStyle.large.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'جلسه جدید',
                                    style: MyTextStyle.base,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'new',
                                    style: MyTextStyle.base.copyWith(backgroundColor: ColorPallet.blue, color: Colors.white, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            '1400/10/02',
                            style: MyTextStyle.small,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AssetImages.logo,
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'دیدار',
                                style: MyTextStyle.large.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'به دیدار خوش آمدید',
                                    style: MyTextStyle.base,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            '1400/10/02',
                            style: MyTextStyle.small,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
