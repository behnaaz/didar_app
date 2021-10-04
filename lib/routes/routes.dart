
import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/screen/message_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/services/auth/AuthWrapper.dart';
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
  // static const String routeCalendar = '/calendar';
  // static const String routeSessions = '/sessions';
  // static const String routeProfile = '/profile';
  // static const String routeSettings = '/settings';
  // static const String routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
  // static const String routeDeviceSetupStartPage = 'find_devices';
  // static const String routeDeviceSetupSelectDevicePage = 'select_device';
  // static const String routeDeviceSetupConnectingPage = 'connecting';
  // static const String routeDeviceSetupFinishedPage = 'finished';
}

// const bottom_navigation_widgets = [
//   routeProfile,
//   routeSessions,
//   routeHome,
//   routeCalendar,
//   routeSettings,
// ];

// var didarRoutes = {
//   routeHome: (context) => AuthWrapper(),
//   routeLogin: (context) => LoginScreen(),
//   routeRegister: (context) => RegisterScreen(),
//   routeCalendar: (context) => BottomNavigationWrapper(),
//   routeSessions: (context) => BottomNavigationWrapper()
// };

// var widgetRoutes = {
//   routeHome: HomeScreen(),
//   routeSettings: SettingScreen(),
//   routeProfile: ProfileScreen(),
//   routeSessions: SessionsScreen(),
//   routeCalendar: CalendarWeeklyScreen(),
//   routeMessages: MessageScreen()
// };

// Widget _findWidget(String route) {
//   if (widgetRoutes.containsKey(route)) {
//     return widgetRoutes[route]!;
//   }

//   return HomeScreen();
// }

// List<Widget> mapToWidget(List<String> routes) {
//   return routes.map((element) => _findWidget(element)).toList();
// }

// Route<dynamic> getRoute(settings) {
//   if (FirebaseAuth.instance.currentUser == null) {
//     return navigateTo(LoginScreen(), settings);
//   }

//   return navigateTo(settings.name, settings);
// }

// MaterialPageRoute<dynamic> navigateTo(screen, settings) {
//   var result = (bottom_navigation_widgets.contains(screen)) ? BottomNavigationWrapper() : _findWidget(screen);
//   return MaterialPageRoute<dynamic>(
//     builder: (context) {
//       return result;
//     },
//     settings: settings,
//   );
// }
