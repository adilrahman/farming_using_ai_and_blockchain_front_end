import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrowdFundingScreen extends StatelessWidget {
  const CrowdFundingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Center(
          child: Text(
            "crowdfunding",
          ),
        ),
      ),
    );
  }
}
