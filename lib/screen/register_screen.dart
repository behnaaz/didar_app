import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/widgets/my_textFormField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextField Controllers ::--::--::--::--::--::--::--::--::--::--::--::--::--:
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  // ::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::--::-

  // For checking the Validations
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _registerButtonIsActive = true;
  bool _acceptTheRules = false;

  void createAccount(authService) async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    // REVIEW - Internet connection check -- ![ Need to check the internet service status]
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // we have internet connection
      //NOTE - Form Validation Check
      if (_formKey.currentState!.validate()) {
        setState(() => _registerButtonIsActive = false);

        // NOTE - try Firebase SignUp Service
        try {
          await authService.signUp(email: emailController.text, password: passwordController.text);
          // ---------------------

          Get.snackbar(
            "خوش آمدید",
            "ثبت نام موفقیت آمیز بود!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue[200],
            borderRadius: 10,
          );
          Get.offAllNamed(HOME_ROUTE, arguments: 'HintActive');
          // ---------------------
        } on FirebaseAuthException catch (e) {
          Get.snackbar("bad connection", "Can't connect to the server", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red[400], borderRadius: 10);
          setState(() => _registerButtonIsActive = true);
          print(e);
        }
      }
    } // NOTE - If Internet WiFi and mobile Data were Disconnected
    else if (connectivityResult == ConnectivityResult.none) {
      // there is NO internet connection
      Get.snackbar("Connection Failed", "Check your internet Connection", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey, borderRadius: 10);
    }
  }

  // ANCHOR : UI Build Widget --------------------------------------------------
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
            child: ListView(
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), border: Border.all(color: ColorPallet.grayBg)),
                      child: Form(
                        key: _formKey,
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
                                  if (value != null) if (!EmailValidator.validate(value)) {
                                    return "لطفا ایمیل خود را به درستی وارد کنید";
                                  }
                                }),
                            myTextFormField(
                                controller: passwordController,
                                label: "کلمه عبور",
                                icon: Icon(Icons.lock),
                                obscureText: true,
                                onChange: (value) {
                                  setState(() {});
                                },
                                suffix: passwordStrength(),
                                validator: (String? value) {
                                  if (value != null) if (estimatePasswordStrength(value) < 0.3) {
                                    return 'کلمه عبور انتخابی ضعیف است!';
                                  }
                                }),
                            myTextFormField(
                                controller: rePasswordController,
                                label: "تکرار کلمه عبور",
                                icon: Icon(Icons.lock),
                                obscureText: true,
                                validator: (String? value) {
                                  if (passwordController.text != value) {
                                    return 'کلمه عبور با تکرار ان مطابقت ندارد!';
                                  }
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Checkbox(
                                        value: _acceptTheRules,
                                        onChanged: (value) {
                                          setState(() {});
                                          _acceptTheRules = value!;
                                        })),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(style: TextStyle(fontSize: 12, color: ColorPallet.textColor, fontWeight: FontWeight.w500, fontFamily: 'IranSans'), children: [
                                      TextSpan(text: 'ضوابط و مقررات ', style: TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dashed, color: ColorPallet.blue)),
                                      TextSpan(
                                        text: 'دیدار را مطالعه کرده و با آن موافقم.',
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: _acceptTheRules
                                  ? _registerButtonIsActive
                                      ? () {
                                          createAccount(authService);
                                        }
                                      : null
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: _registerButtonIsActive
                                    ? Text("ثبت نام")
                                    : Container(
                                        height: 14,
                                        width: 14,
                                        child: CircularProgressIndicator(
                                          color: ColorPallet.blue,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "قبلا ثبت نام کردید",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OutlinedButton(
                                  child: Text("وارد شوید"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LOcal Widget Function -----------------------------------------------------
  Widget passwordStrength() {
    if (estimatePasswordStrength(passwordController.text) < 0.3) {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          'ضعیف!',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (estimatePasswordStrength(passwordController.text) < 0.7) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          'متوسط!',
          style: TextStyle(color: Colors.yellow[800]),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          'قوی!',
          style: TextStyle(color: Colors.green),
        ),
      );
    }
  }
  // End  ----------------------------------------------------------------------

}
