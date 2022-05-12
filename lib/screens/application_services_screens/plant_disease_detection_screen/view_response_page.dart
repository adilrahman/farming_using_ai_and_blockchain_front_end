import 'dart:io';

import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/application_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

final RestApiInteraction backendInterFace =
    Get.put(RestApiInteraction(), tag: "backend");

class ViewResponsePage extends StatelessWidget {
  ViewResponsePage({required imageFile, Key? key})
      : _imageFile = imageFile,
        super(key: key);

  final File _imageFile;
  var _color = Colors.green;
  var _isFound = "FOUND : ";
  var _disease = "desease";
  var _isPositive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      appBar: AppBar(
        backgroundColor: AppColor.gradientSecond,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 350,
              width: 250,
              child: Image.file(
                _imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _isPositive
              ? Result(color: _color, isFound: _isFound, disease: _disease)
              : Result(color: Colors.red, isFound: "NOT FOUND", disease: ""),
          SizedBox(
            height: 20,
          ),
          SingleButton(
              icon: FontAwesomeIcons.search,
              text: Text("TEST"),
              method: uploadImage)
        ],
      ),
    );
  }

  uploadImage() {
    backendInterFace.cropDiseasePrediction(_imageFile);
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required MaterialColor color,
    required String isFound,
    required String disease,
  })  : _color = color,
        _isFound = isFound,
        _disease = disease,
        super(key: key);

  final MaterialColor _color;
  final String _isFound;
  final String _disease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      color: _color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isFound,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(_disease, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
