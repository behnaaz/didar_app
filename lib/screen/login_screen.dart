import 'package:connectivity/connectivity.dart';
import 'package:didar_app/Constants/them_conf.dart';

import 'package:didar_app/screen/register_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/widgets/my_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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

  ///Login Action Button
  void loginButton(authService) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // we have internet connection
      if (_formKey.currentState!.validate()) {
        setState(() => _loginButtonIsActive = false);
        try {
          dynamic result = await authService.signIn(
              email: emailController.text, password: passwordController.text);

          Get.snackbar("You are login successfully", "Have fun",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue[200],
              borderRadius: 10);
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Sorry", "${e.message}",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[400],
              borderRadius: 10);
          setState(() => _loginButtonIsActive = true);
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
      backgroundColor: ColorPallet.lightGrayBg,
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            AssetImages.patternAuthBg,
            fit: BoxFit.cover,
          )),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ColorPallet.grayBg)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Image.asset(
                              AssetImages.logo,
                              height: 50,
                            ),
                          ),
                          myTextFormField(
                              controller: emailController,
                              label: "ایمیل",
                              icon: Icon(Icons.email),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "pls Enter Email";
                                }
                              }),
                          myTextFormField(
                              controller: passwordController,
                              label: "کلمه عبور",
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: _loginButtonIsActive
                                ? () => loginButton(authService)
                                : null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: _loginButtonIsActive
                                  ? Text(
                                      "ورود",
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
                              Text("اگه هنوز اکانت نداری"),
                              SizedBox(
                                width: 5,
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Get.to(() => RegisterScreen());
                                },
                                child: Text(
                                  "همین الان ثبت نام کن",
                                  style: TextStyle(color: ColorPallet.blue),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
