import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/screen/message_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/routes/AuthWrapper.dart';
import 'package:get/get_navigation/get_navigation.dart';

List<GetPage<dynamic>>? routPage = [
  GetPage(name: RoutesName.register, page: () => RegisterScreen()),
  GetPage(name: RoutesName.login, page: () => LoginScreen()),
  GetPage(name: RoutesName.home, page: () => AuthWrapper()),
  GetPage(name: RoutesName.messages, page: () => MessageScreen()),
];

class RoutesName {
  RoutesName._();
  static const String register = '/register';
  static const String login = '/login';
// Auth Wrapper or bottom navigation Wrapper Pages
  static const String home = '/';
  static const String messages = '/messages';
}
