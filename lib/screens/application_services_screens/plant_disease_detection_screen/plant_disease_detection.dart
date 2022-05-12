import 'dart:io';
import 'dart:async';
import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/plant_disease_detection_screen/view_response_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PlantDiseaseDetectionScreen extends StatelessWidget {
  const PlantDiseaseDetectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.homePageBackground,
        appBar: AppBar(
          title: Text("Plant Disease Detection"),
          centerTitle: true,
          backgroundColor: AppColor.gradientSecond,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleButton(
                  icon: Icons.camera,
                  text: const Text("Capture Image"),
                  method: () {
                    _getFromCamera();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SingleButton(
                  icon: Icons.image,
                  text: const Text("Pick Image"),
                  method: () {
                    _getFromGallery();
                  },
                )
              ],
            ),
          ),
        ));
  }
}

/// Get from gallery
_getFromGallery() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    Get.to(ViewResponsePage(
      imageFile: imageTemp,
    ));
  } on PlatformException catch (e) {
    print("Failed to pick Image ${e}");
  }
}

/// Get from gallery
_getFromCamera() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemp = File(image.path);
    Get.to(ViewResponsePage(
      imageFile: imageTemp,
    ));
  } on PlatformException catch (e) {
    print("Failed to pick Image ${e}");
  }
}

class SingleButton extends StatelessWidget {
  const SingleButton(
      {Key? key, required IconData icon, required Text text, required method})
      : _icon = icon,
        _text = text,
        _method = method,
        super(key: key);

  final IconData _icon;
  final Text _text;
  final _method;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          _method();
        },
        style: ElevatedButton.styleFrom(
            primary: AppColor.gradientFirst,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        icon: Icon(_icon),
        label: _text);
  }
}
