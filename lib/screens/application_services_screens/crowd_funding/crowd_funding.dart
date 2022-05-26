import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/adding_new_project_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/current_projects_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrowdFundingScreen extends StatefulWidget {
  final username;
  final etherAddress;

  CrowdFundingScreen({Key? key, required username, required ethAddress})
      : username = username,
        etherAddress = ethAddress,
        super(key: key);

  @override
  State<CrowdFundingScreen> createState() =>
      _CrowdFundingScreenState(username: username, ethAddress: etherAddress);
}

class _CrowdFundingScreenState extends State<CrowdFundingScreen> {
  var username;
  var ethAddress;

  _CrowdFundingScreenState(
      {required this.username, required this.ethAddress}) {}
  int _currentPageIndex = 0;

  final _pages = [addingNewProjectScreen(), currentProjectsStatusScreen()];

  @override
  void initState() {
    retriveUserData();
    super.initState();
  }

  retriveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username")!;
    ethAddress = prefs.getString("ethAddress")!;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectListModel(),
      child: Scaffold(
        backgroundColor: AppColor.homePageBackground,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.gradientSecond,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("CROWDFUNDING"),
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
                  icon: Icon(Icons.add_box_outlined),
                  label: "create new project"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: "my projects")
            ]),
      ),
    );
  }
}
