import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("signIN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: emailController,
               
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          color: Colors.yellow,
                          style: BorderStyle.solid,
                          width: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          color: Colors.yellow,
                          style: BorderStyle.solid,
                          width: 2)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await authService.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  child: Text("SignIn"),
                ),
                SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: Text("Register now"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
