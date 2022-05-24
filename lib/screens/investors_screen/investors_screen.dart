import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_investors_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_view_all_projects.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_view_invested_projects.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'investors_detailed_screen.dart';
import 'package:provider/provider.dart';

class InvestorsScreen extends StatefulWidget {
  const InvestorsScreen({Key? key}) : super(key: key);

  @override
  State<InvestorsScreen> createState() => _InvestorsScreenState();
}

class _InvestorsScreenState extends State<InvestorsScreen> {
  final _username = "Username";

  final _projectname = "project name";

  final _description =
      "it is good description though it is good description though it is good description though";

  final _postedDate = "1 day left";

  final _totalAmount = "5";

  final _percentageOfCompletion = 0.6;

  final _percentageOfCompletionInText = "60%";
  int _currentPageIndex = 0;

  //TODO : should remove the parameters
  final _pages = [
    InvestorViewInvestedProjects(
        username: "",
        projectname: "_projectname",
        postedDate: "_postedDate",
        description: "_description",
        totalAmount: "_totalAmount",
        percentageOfCompletion: 0.6,
        percentageOfCompletionInText: "60%"),
    InvestorViewAllProjects(
        username: "",
        projectname: "_projectname",
        postedDate: "_postedDate",
        description: "_description",
        totalAmount: "_totalAmount",
        percentageOfCompletion: 0.6,
        percentageOfCompletionInText: "60%"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InvesorsProjectListModel(),
      child: Scaffold(
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
                    label: "Invested projects"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "All projects")
              ])),
    );
  }
}
