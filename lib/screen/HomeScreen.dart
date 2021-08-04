import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("DIDAR"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.signOut();
            Get.to(SignInScreen());
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
