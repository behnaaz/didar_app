import 'package:connectivity/connectivity.dart';
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
  // TextField Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _registerButtonIsActive = true;

  // Create Account button Function
  void createAccount(authService) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    // REVIEW - Internet connection check -- ![ Need to check the internet service status]
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // we have internet connection

      //NOTE - Form Validation Check
      if (_formKey.currentState!.validate()) {
        setState(() => _registerButtonIsActive = false);

        // NOTE - try Firebase SignUp Service
        try {
          await authService.signUp(
              fullName: fullNameController.text,
              email: emailController.text,
              password: passwordController.text);
          Navigator.pop(context);
          Get.snackbar("You are register successfully", "Have fun",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue[200],
              borderRadius: 10);
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Sorry", "${e.message}",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[400],
              borderRadius: 10);
          setState(() => _registerButtonIsActive = true);
        }
      }
    } // NOTE - If Internet WiFi and mobile Data were Disconnected
    else if (connectivityResult == ConnectivityResult.none) {
      // there is NO internet connection
      Get.snackbar("Connection Failed", "Check your internet Connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          borderRadius: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              myTextFormField(
                  controller: fullNameController,
                  label: "Full name",
                  icon: Icon(Icons.person),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "pls Enter your full name";
                    }
                  }),
              myTextFormField(
                  controller: emailController,
                  label: "Email",
                  icon: Icon(Icons.email),
                  validator: (String? value) {
                    if (value != null) if (!EmailValidator.validate(value)) {
                      return "pls Enter valid Email";
                    }
                  }),
              myTextFormField(
                  controller: passwordController,
                  label: "Password",
                  icon: Icon(Icons.lock),
                  obscureText: true,
                  onChange: (value) {
                    setState(() {});
                  },
                  suffix: passwordStrength(),
                  validator: (String? value) {
                    if (value != null) if (estimatePasswordStrength(value) <
                        0.3) {
                      return 'This password is weak!';
                    }
                  }),
              myTextFormField(
                  controller: rePasswordController,
                  label: "Password confirm",
                  icon: Icon(Icons.lock),
                  obscureText: true,
                  validator: (String? value) {
                    if (passwordController.text != value) {
                      return 'Password Confirm are not match!';
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
                onPressed: _registerButtonIsActive
                    ? () {
                        createAccount(authService);
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _registerButtonIsActive
                      ? Text("Create account")
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
                  Text("Have an account"),
                  SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                    child: Text("Login"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // LOcal Widget Function -----------------------------------------------------
  Text passwordStrength() {
    if (estimatePasswordStrength(passwordController.text) < 0.3) {
      return Text(
        'weak!',
        style: TextStyle(color: Colors.red),
      );
    } else if (estimatePasswordStrength(passwordController.text) < 0.7) {
      return Text(
        'alright!',
        style: TextStyle(color: Colors.yellow[800]),
      );
      ;
    } else {
      return Text(
        'strong!',
        style: TextStyle(color: Colors.green),
      );
    }
  }
  // End  ----------------------------------------------------------------------

}
