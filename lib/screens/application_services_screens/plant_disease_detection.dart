import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantDiseaseDetectionScreen extends StatelessWidget {
  const PlantDiseaseDetectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Center(
          child: Text(
            "Plant disease detection",
          ),
        ),
      ),
    );
  }
}
