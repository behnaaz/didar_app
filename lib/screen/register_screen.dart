import 'package:didar_app/auth/authenticatService.dart';
import 'package:flutter/material.dart';
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
                  icon: Icon(Icons.person)),
              myTextFormField(
                  controller: emailController,
                  label: "ٍEmail",
                  icon: Icon(Icons.email)),
              myTextFormField(
                controller: passwordController,
                label: "Password",
                icon: Icon(Icons.lock),
                obscureText: true,
              ),
              myTextFormField(
                controller: rePasswordController,
                label: "Password confirm",
                icon: Icon(Icons.lock),
                obscureText: true,
              ),
              passwordController.text == rePasswordController.text
                  ? Text('')
                  : Text(
                      'Password Confirm are not match!',
                      style: TextStyle(color: Colors.redAccent[700]),
                    ),
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
                  createAccount(authService);
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
                  )
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
      Widget? icon,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
