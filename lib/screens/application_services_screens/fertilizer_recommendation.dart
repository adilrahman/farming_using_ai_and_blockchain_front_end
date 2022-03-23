import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FertilizerRecommendationScreen extends StatelessWidget {
  const FertilizerRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Center(
          child: Text(
            "fertilizer recommendation",
          ),
        ),
      ),
    );
  }
}
