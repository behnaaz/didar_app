import 'package:didar_app/screen/_bottom_nav_wrapper.dart';
import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/screen/message_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

const String HOME_ROUTE = '/';
const String MESSAGE_ROUTE = '/messages';
const String REGISTER_ROUTE = '/register';
const String LOGIN_ROUTE = '/login';

const String RETURN_PARAM = 'return';

String loginWithRedirect(String returnUrl) =>
    LOGIN_ROUTE + '?' + RETURN_PARAM + '=' + returnUrl;

List<GetPage<dynamic>>? routes = [
  GetPage(name: REGISTER_ROUTE, page: () => RegisterScreen()),
  GetPage(name: LOGIN_ROUTE, page: () => LoginScreen()),
  GetPage(
      name: HOME_ROUTE,
      page: () => BottomNavigationWrapper(),
      middlewares: [AuthAssure()]),
  GetPage(
      name: MESSAGE_ROUTE,
      page: () => MessageScreen(),
      middlewares: [AuthAssure()]),
];

class AuthAssure extends GetMiddleware {
  RouteSettings? redirect(String? route) {
    String returnUrl = Uri.encodeFull(route ?? HOME_ROUTE);
    return AuthenticationService.authenticatedUser() == null
        ? null
        : RouteSettings(name: loginWithRedirect(returnUrl));
  }
}
