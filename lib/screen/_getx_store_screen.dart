import 'package:flutter/material.dart';

class GetxStoreTestScreen extends StatelessWidget {
  const GetxStoreTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Store"),),
      body: Center(
        child: Text("Getxx"),
      ),
    );
  }
}
