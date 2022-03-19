import 'package:flutter/material.dart';

// its the background image of sign in and sign up screens
class BackgroundImageOfSign extends StatelessWidget {
  const BackgroundImageOfSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.colorBurn),
                image: AssetImage("assets/images/login_background.jpg"))),
      ),
    );
  }
}

class BackgroundImageOfInvestorSign extends StatelessWidget {
  const BackgroundImageOfInvestorSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.colorBurn),
                image: AssetImage(
                    "assets/images/investor_login_background.jpeg"))),
      ),
    );
  }
}

class BackgroundImageOfPlantDiseaseDetection extends StatelessWidget {
  const BackgroundImageOfPlantDiseaseDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                opacity: 1,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.colorBurn),
                image: AssetImage(
                    "assets/images/bg_plant_disease_detection.jpg"))),
      ),
    );
  }
}
