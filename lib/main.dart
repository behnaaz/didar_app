import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DidarApp());
}

class DidarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(create: (_) => AuthenticationService()),
      ],
      child: GetMaterialApp(
        locale: const Locale('fa', 'IR'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'IranSans',
          scaffoldBackgroundColor: ColorPallet.lightGrayBg,
          // primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: ColorPallet.grayBg)),
          // primaryColor: Colors.blue[900],
        ),
        onGenerateRoute: getRoute,
        initialRoute: routeHome,
        routes: didarRoutes,
      ),
    );
  }
}
