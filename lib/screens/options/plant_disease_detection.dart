import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantDiseaseDetection extends StatelessWidget {
  const PlantDiseaseDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Plant disease detection",
        ),
      ),
    );
  }
}
