import 'dart:convert';
import 'dart:io';

import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/application_services.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

final RestApiInteraction backendInterFace =
    Get.put(RestApiInteraction(), tag: "backend");

class ViewResponsePage extends StatefulWidget {
  ViewResponsePage({required imageFile, Key? key})
      : _imageFile = imageFile,
        super(key: key);

  final File _imageFile;

  @override
  State<ViewResponsePage> createState() => _ViewResponsePageState();
}

class _ViewResponsePageState extends State<ViewResponsePage> {
  var _color = Colors.green;

  var _isFound = "FOUND : ";

  var _disease = "desease";

  var _isPositive = false;

  bool _isLoading = false;

  bool _onPressed = false;
  String plantName = "not found";
  String disease = "not found";

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
              padding: const EdgeInsets.only(top: 20),
              height: 350,
              width: 250,
              child: Image.file(
                widget._imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _onPressed
              ? Result(
                  isHealthy: _isPositive,
                  plantName: plantName,
                  disease: disease)
              : Container(),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? APILoading()
              : SingleButton(
                  icon: FontAwesomeIcons.search,
                  text: const Text("TEST"),
                  method: uploadImage)
        ],
      ),
    );
  }

  uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var response =
        await backendInterFace.cropDiseasePrediction(widget._imageFile);
    response = jsonDecode(response);
    setState(() {
      _isLoading = false;
      _onPressed = true;
      _isPositive = response["healthy"];
      plantName = response["plant name"].toString();
      disease = response["disease"].toString();
    });
    print(plantName);
    // if(response.toString())
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required bool isHealthy,
    required String plantName,
    required String disease,
  })  : _isHealthy = isHealthy,
        _plantName = plantName,
        _disease = disease,
        super(key: key);

  final String _plantName;
  final String _disease;
  final bool _isHealthy;

  @override
  Widget build(BuildContext context) {
    return _isHealthy
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            color: Colors.green,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "plant name : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text("${_plantName.toString()}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    const Text(
                      "Condition : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_disease.toString()}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            color: Colors.red,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "plant name : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text("${_plantName.toString()}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
                Divider(),
                Row(
                  children: const [
                    Text(
                      "Condition : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Not healthy",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    const Text(
                      "Disease : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text("${_disease.toString()}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
              ],
            ),
          );
  }
}
