import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestorDetailedScreen extends StatelessWidget {
  const InvestorDetailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.snackbar("title", "message");
          },
          label: Text("Invest")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
