import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/screen/message_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/routes/AuthWrapper.dart';
import 'package:get/get_navigation/get_navigation.dart';

List<GetPage<dynamic>>? routPage = [
  GetPage(name: RoutesName.register, page: () => RegisterScreen()),
  GetPage(name: RoutesName.login, page: () => LoginScreen()),
  GetPage(name: RoutesName.homeNavigationWrapper, page: () => AuthWrapper()),
  GetPage(name: RoutesName.messages, page: () => MessageScreen()),
  // GetPage(name: RoutesName.secondApp , page: () => SeApp(), transition: Transition.zoom),
];

class RoutesName {
  RoutesName._();
// Auth
  static const String register = '/register';
  static const String login = '/login';
// ----------------
// Auth Wrapper or bottom navigation Wrapper Pages
  static const String homeNavigationWrapper = '/';
// ----------------
  static const String messages = '/messages';
}
