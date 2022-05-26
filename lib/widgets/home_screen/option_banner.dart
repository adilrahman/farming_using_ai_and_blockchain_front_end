import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

class OptionBanner extends StatelessWidget {
  const OptionBanner({
    Key? key,
    required this.bg_source,
    required this.serviceName,
    required this.goToPage,
  }) : super(key: key);

  final String bg_source;
  final String serviceName;
  final goToPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(goToPage,
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 1500));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 14, top: 20, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.colorBurn),
                fit: BoxFit.cover,
                image: AssetImage(bg_source)),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 55,
                  offset: Offset(20, 15),
                  color: Colors.black87),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  serviceName,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            const Icon(
              FontAwesomeIcons.arrowAltCircleRight,
              color: Colors.white54,
            )
          ],
        ),
      ),
    );
  }
}
