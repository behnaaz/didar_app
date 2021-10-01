import 'package:didar_app/screen/_bottom_nav_wrapper.dart';
import 'package:didar_app/screen/login_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:didar_app/model/user_model.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NOTE : AuthService Provider
     AuthenticationService authService =
        Provider.of<AuthenticationService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
           User? user = snapshot.data;
          print(user.toString()); // LOG : USER is Exist or not
          if (user != null)
            print(
                "uni ID:" + user.uid.toString()); // LOG : USER is Exist or not

          return user == null ? LoginScreen() : BottomNavigationWrapper();//TODO behnaz
        }
        // NOTE :  IF Snapshot ConnectionState is Not ACTIVE
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
