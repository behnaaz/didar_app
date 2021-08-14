import 'package:flutter/material.dart';

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
      onChanged: onChange,
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
