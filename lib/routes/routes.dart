import 'package:didar_app/screen/_bottom_nav_wrapper.dart';
import 'package:didar_app/screen/calendar_weekly_screen.dart';
import 'package:didar_app/screen/home_screen.dart';
import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/screen/message_screen.dart';
import 'package:didar_app/screen/profile/profile_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/screen/sessions_screen.dart';
import 'package:didar_app/screen/setting_screen.dart';
import 'package:didar_app/services/auth/AuthWrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const routeHome = '/';
const routeRegister = '/register';
const routeLogin = '/login';
const routeProfile = '/profile';
const routeSettings = '/settings';
const routeCalendar = '/calendar';
const routeSessions = '/sessions';
const routeMessages = '/messages';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

var logger = Logger();

const bottom_navigation_widgets = [
  routeProfile,
  routeSessions,
  routeHome,
  routeCalendar,
  routeSettings,
];

var didarRoutes = {
  routeHome: (context) => AuthWrapper(),
  routeLogin: (context) => LoginScreen(),
  routeRegister: (context) => RegisterScreen(),
  routeCalendar: (context) => BottomNavigationWrapper(screen: routeCalendar),
  routeSessions: (context) => BottomNavigationWrapper(screen: routeSessions)
};

var widgetRoutes = {
  routeHome: HomeScreen(),
  routeSettings: SettingScreen(),
  routeProfile: ProfileScreen(),
  routeSessions: SessionsScreen(),
  routeCalendar: CalendarWeeklyScreen(),
  routeMessages: MessageScreen()
};

Widget _findWidget(final String route) {
  if (widgetRoutes.containsKey(route)) {
    return widgetRoutes[route]!;
  }

  logger.log(Level.error, "FIXME!! Unknown route: {0}", route);
  return HomeScreen();
}

List<Widget> mapToWidget(List<String> routes) {
  return routes.map((element) => _findWidget(element)).toList();
}

Route<dynamic> getRoute(settings) {
  if (FirebaseAuth.instance.currentUser == null) {
    return navigateTo(LoginScreen(), settings);
  }

  return navigateTo(settings.name, settings);
}

MaterialPageRoute<dynamic> navigateTo(screen, settings) {
  var result = (bottom_navigation_widgets.contains(screen)) ?
                BottomNavigationWrapper(screen: screen) :
                _findWidget(screen);
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return result;
    },
    settings: settings,
  );
}