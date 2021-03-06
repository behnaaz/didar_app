import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String statusBox = 'status';
const double appMaxWithSize = 800; 

// ::> Colors  -----------------------------------------------------------------
class ColorPallet {
  ColorPallet._();
  static const Color blue = Color(0xff00b2e2);
  static const Color lightBlue = Color(0xff9fceef);
  static const Color cyan = Color(0xff9fefdf);
  static const Color red = Color(0xfff24137);
  static const Color lightRed = Color(0xffefa49f);
  static const Color textColor = Color(0xff606060);
  static const Color grayBg = Color(0xffa9a9a9);
  static const Color lightGrayBg = Color(0xfff4f4f4);
  static const Color pink = Color(0xffec9fef);
  static const Color violet = Color(0xffaa9fef);
  static const Color green = Color(0xff9fefdf);
  static const Color yellow = Color(0xffefe59f);
}

// ::> Image Address  ----------------------------------------------------------
const List<Color> sessionsColorList = [
  ColorPallet.lightBlue,
  ColorPallet.green,
  ColorPallet.yellow,
  ColorPallet.cyan,
  ColorPallet.pink,
  ColorPallet.violet,
  ColorPallet.lightRed,
];

class AssetImages {
  AssetImages._();

  /// main logo of Didar App
  static const String logo = "assets/images/Didar-Logo-Final-T.png";

  /// white pattern for the sign in/up screen
  static const String patternAuthBg = "assets/images/auth_bg_pattern.png";

  /// User Empty Avatar png
  static const String userEmptyAvatar = "assets/images/user.png";

  /// Edit Icon
  static const String editIcon = "assets/images/edit.png";

  /// Email stylish icon used in Appbar
  static const String emailIcon = "assets/images/email.png";

  /// Calendar png that used as placeholder when sessions list is empty
  static const String sessionPlaceholder = "assets/images/empty-session-placeholder.png";

  /// Calendar png that used as placeholder second version
  static const String sessionPlaceholder2 = "assets/images/home-empty-session.png";

  /// Nice PNG header for Home page
  static const String homeHeader = "assets/images/home-header.png";

  /// Rate badge icon
  static const String badgeRate = "assets/images/rate-badge.png";

  /// Didar coin badge icon
  static const String badgeDidarCoin = "assets/images/didar-coin-badge.png";

  /// student badge icon
  static const String badgeStudent = "assets/images/student-badge.png";

  /// Custom (Didar) payment card Icon
  static const String iconSessionSetting = "assets/images/d-icon-session-setting.png";

  /// Custom (Didar) Work Calendar Icon
  static const String iconWorkCalendar = "assets/images/d-icon-calendar.png";

  /// Custom (Didar) session Add Icon
  static const String iconAddSession = "assets/images/d-icon-session.png";

  /// Custom (Didar) Revenue Icon
  static const String iconRevenue = "assets/images/d-icon-revenue.png";

  /// Custom (Didar) Pay Card Icon
  static const String iconFinancialStuff = "assets/images/d-icon-pay.png";

  /// Custom (Didar) statistic chart  Icon
  static const String iconChartStatistic = "assets/images/d-statistics-chart.png";

  static const String calendarHint = "assets/images/finger_point.png";
  static const String avatarWhite = "assets/images/avatar-white.png";
}

// ::> TextStyle  --------------------------------------------------------------
/// fontSize for :
/// [xSmall] | 10
/// [small] | 12
/// [base]  | 14
/// [large]  | 16
/// [pageTile]  | 20
class MyTextStyle {
  MyTextStyle._();

  static final TextStyle base = const TextStyle(fontFamily: "IranSans", color: ColorPallet.textColor, fontSize: 14);

  /// FontSize is '10'
  static final TextStyle xSmall = base.copyWith(fontSize: 10);

  /// FontSize is '12'
  static final TextStyle small = base.copyWith(fontSize: 12);

  /// FontSize is '16'
  static final TextStyle large = base.copyWith(fontSize: 16);

  /// FontSize is '20'
  static final TextStyle pageTitle = base.copyWith(fontSize: 20);
}
