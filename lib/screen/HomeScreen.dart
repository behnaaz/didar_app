import 'package:didar_app/auth/authenticatService.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIDAR"),
      ),
      body: Center(
           child: ElevatedButton(
              onPressed: () {
                // context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            ),
      ),
    );
  }
}
