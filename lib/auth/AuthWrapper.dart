import 'package:didar_app/screen/home_screen.dart';
import 'package:didar_app/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:didar_app/auth/authenticatService.dart';
import 'package:provider/provider.dart';
import 'package:didar_app/model/User.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NOTE : AuthService Provider
    final AuthenticationService authService =
        Provider.of<AuthenticationService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          print(user.toString()); // LOG : USER is Exist or not
          return user == null ? SignInScreen() : HomeScreen();
        } else {
          // NOTE :  IF Snapshot ConnectionState is Not ACTIVE
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
