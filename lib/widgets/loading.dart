import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// contains all loading widgets
//
class MainLoading extends StatelessWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const SpinKitThreeInOut(
        color: Colors.blueAccent,
      ),
    );
  }
}
