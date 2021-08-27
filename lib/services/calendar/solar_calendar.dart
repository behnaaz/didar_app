import 'package:shamsi_date/shamsi_date.dart';

enum ali { asd, asdd, dda }

class SolarCalendar {
  static List<String> daysOfTheWeek = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];

  static List<String> monthNameList = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  Jalali now() {
    return Jalali.now();
  
  }
}
