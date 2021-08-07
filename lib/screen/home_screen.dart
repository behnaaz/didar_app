import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/_test_screen.dart';
import 'package:didar_app/screen/signin_screen.dart'; // TODO lets follow the flutter convention and keep the file names lower case, once the comments addressed, please feel free to delete them

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text("DIDAR"),
        title: Image.asset(kImageLogo,height: 45,),
        centerTitle: true,
        leading: Icon(Icons.email),
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOut();
               
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: TestScreen(),
    );
  }
}
