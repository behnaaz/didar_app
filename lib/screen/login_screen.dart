
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/widgets/my_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      if (_formKey.currentState!.validate()) {
        setState(() => _loginButtonIsActive = false);
        try {
          await authService.signIn(
              email: emailController.text, password: passwordController.text);
        } on FirebaseAuthException catch (e) {
          logger.d(e);
          //TODO Farsi
          Get.snackbar("Error",
              "Please check your username, password, network connection,...",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[400],
              borderRadius: 10);
          setState(() => _loginButtonIsActive = true);
        }

        String returnUrl = Get.parameters[RETURN_PARAM] ?? HOME_ROUTE;
        Get.offAllNamed(returnUrl);
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Connection Failed", "Check your internet Connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          borderRadius: 10);
    }
  }

// ANCHOR : UI Build Widget ----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            AssetImages.patternAuthBg,
            fit: BoxFit.cover,
          )),
          SafeArea(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                constraints: BoxConstraints(maxWidth: 800),
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
                                    : Container(
                                        height: 14,
                                        width: 14,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Text(
                                    "اگه هنوز ثبت نام نکردی ",
                                    textAlign: TextAlign.center,
                                    style: MyTextStyle.small,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed(REGISTER_ROUTE);
                                    },
                                    child: Text(
                                      "همین الان ثبت نام کن",
                                      style: TextStyle(color: ColorPallet.blue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
