import 'package:didar_app/auth/AuthWrapper.dart';
import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/screen/signin_screen.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(color: Colors.blue[900]),
            primaryColor: Colors.blue[900]),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthWrapper(),
          '/signIN': (context) => SignInScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}

