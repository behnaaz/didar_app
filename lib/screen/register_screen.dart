import 'package:didar_app/auth/authenticatService.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
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

  // Create Account button Function
  void createAccount(authService) async {
    if (passwordController.text == rePasswordController.text) {
      await authService.signUp(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text);
      print("i am registered succecfully"); // LOG : user registered
      Navigator.pop(context);
    }
    setState(() {});
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
                  onChange: (value){
                    setState(() {
                      
                    });
                  },
                  suffix:  passwordStrength(),
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
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                  
                  createAccount(authService);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Create account"),
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

  Widget myTextFormField(
      {required TextEditingController controller,
      required String label,
      String? Function(String? value)? validator,
      void Function(String value)? onChange,
      Widget? icon,
      Widget? suffix,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged: 
        onChange,
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          suffix: suffix,
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

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
}
