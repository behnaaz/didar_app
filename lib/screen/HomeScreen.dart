import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/SignInScreen.dart';// TODO lets follow the flutter convention and keep the file names lower case, once the comments addressed, please feel free to delete them
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
