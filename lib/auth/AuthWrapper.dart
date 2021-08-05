import 'package:didar_app/screen/home_screen.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:didar_app/auth/authenticatService.dart';
import 'package:provider/provider.dart';
import 'package:didar_app/model/User.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService authService =
        Provider.of<AuthenticationService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print("i am not alone");
          final User? user = snapshot.data;
          print(user.toString());
          return user == null ? SignInScreen() : HomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
