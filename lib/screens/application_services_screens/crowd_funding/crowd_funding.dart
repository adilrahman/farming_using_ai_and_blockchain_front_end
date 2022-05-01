import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/adding_new_project_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/current_projects_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CrowdFundingScreen extends StatefulWidget {
  const CrowdFundingScreen({Key? key}) : super(key: key);

  @override
  State<CrowdFundingScreen> createState() => _CrowdFundingScreenState();
}

class _CrowdFundingScreenState extends State<CrowdFundingScreen> {
  int _currentPageIndex = 0;
  final _pages = const [
    addingNewProjectScreen(),
    currentProjectsStatusScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.gradientSecond,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("CROWDFUNDING"),
            Icon(FontAwesomeIcons.ethereum),
          ],
        ),
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.gradientSecond,
          selectedItemColor: AppColor.homePageBackground,
          currentIndex: _currentPageIndex,
          onTap: (value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "List")
          ]),
    );
  }
}
