import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/signin_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:didar_app/model/user_profile.dart';
import 'package:didar_app/persistance/user_profile_dao.dart';

import 'home_screen.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await authService.signUp(
                        email: emailController.text,
                        password: passwordController.text);
                      print("i am alive");
                    Navigator.pop(context);
                    Get.to(HomeScreen());
                  },
                  child: Text("Create account"),//TODO add the user profile fields and mae a call to user_profle_dao to save the user_profile in database in after creating 
                                                // the user so the user id is saved in the profile as well
                                                // I have created the file skeleton, please feel free to delete this comment when it is addressed
                ),
                SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.to(SignInScreen());
                  },
                  child: Text("sign in"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
