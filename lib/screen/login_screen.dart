import 'package:connectivity/connectivity.dart';

import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/widgets/my_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginButtonIsActive = true;
  void loginButton(authService) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // we have internet connection
      if (_formKey.currentState!.validate()) {
        setState(() {
          _loginButtonIsActive = false;
        });
        try {
          dynamic result = await authService.signIn(
              email: emailController.text, password: passwordController.text);

          Get.snackbar("You are login sucessfully", "Have fun",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue[200],
              borderRadius: 10);
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Sorry", "${e.message}",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[400],
              borderRadius: 10);
          setState(() {
            _loginButtonIsActive = true;
          });
        }
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      // there is NO internet connection
      Get.snackbar("Connection Failed", "Check your internet Connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          borderRadius: 10);
    }
  }

// ANCHOR : UI Build Widget ----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                myTextFormField(
                    controller: emailController,
                    label: "Email",
                    icon: Icon(Icons.email),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "pls Enter Email";
                      }
                    }),
                myTextFormField(
                    controller: passwordController,
                    label: "Password",
                    icon: Icon(Icons.lock),
                    obscureText: true,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "pls Enter password";
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: _loginButtonIsActive
                      ? () => loginButton(authService)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: _loginButtonIsActive
                        ? Text(
                            "Login",
                            style: TextStyle(fontSize: 16),
                          )
                        : CircularProgressIndicator(
                            color: Colors.black,
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account"),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
