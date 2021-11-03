import 'package:flutter/material.dart';
import 'package:didar_app/constants/them_conf.dart';


class SettingItem {
  final String icon;
  final String label;
  SettingItem({required this.icon, required this.label});
}

class SettingScreen extends StatelessWidget {
  final List<SettingItem> _listOfSettingItem = [
    SettingItem(icon: AssetImages.iconWorkCalendar, label: 'تقویم کاری'),
    SettingItem(icon: AssetImages.iconAddSession, label: 'ثبت جلسه'),
    SettingItem(icon: AssetImages.iconSessionSetting, label: 'مشخصات جلسه'),
    SettingItem(icon: AssetImages.iconRevenue, label: 'بازاریابی'),
    SettingItem(icon: AssetImages.iconFinancialStuff, label: 'امور مالی'),
    SettingItem(icon: AssetImages.iconChartStatistic, label: 'فروش'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(constraints: BoxConstraints(maxWidth: appMaxWithSize),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          children: List.generate(
              _listOfSettingItem.length,
              (index) => Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _listOfSettingItem[index].icon,
                      width: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_listOfSettingItem[index].label)
                  ],
                )),
              )),
        ),
      ),
    );
  }
}
