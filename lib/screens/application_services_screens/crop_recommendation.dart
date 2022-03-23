import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropRecommendationScreen extends StatelessWidget {
  const CropRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Center(
          child: Text(
            "crop recommendation",
          ),
        ),
      ),
    );
  }
}
