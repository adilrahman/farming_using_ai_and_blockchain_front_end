import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_investors_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_view_all_projects.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_view_invested_projects.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestorsScreen extends StatefulWidget {
  final LogInfo logInfo;
  InvestorsScreen({Key? key, required this.logInfo}) : super(key: key);

  @override
  State<InvestorsScreen> createState() => _InvestorsScreenState(this.logInfo);

  var p = 10;
}

class _InvestorsScreenState extends State<InvestorsScreen> {
  LogInfo _logInfo = LogInfo(userName: "", etherAddress: "");
  _InvestorsScreenState(LogInfo logInfo) {
    this._logInfo = logInfo;
  }

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _pages = [
      InvestorViewInvestedProjects(
        username: _logInfo.userName.toString(),
        projectname: "_projectname",
        postedDate: "_postedDate",
        description: "_description",
        totalAmount: "_totalAmount",
        percentageOfCompletion: 0.6,
        percentageOfCompletionInText: "60%",
        ethAddress: _logInfo.etherAddress.toString(),
      ),
      InvestorViewAllProjects(
        username: _logInfo.userName.toString(),
        projectname: "_projectname",
        postedDate: "_postedDate",
        description: "_description",
        totalAmount: "_totalAmount",
        percentageOfCompletion: 0.6,
        percentageOfCompletionInText: "60%",
        ethAddress: _logInfo.etherAddress.toString(),
      ),
    ];

    return ChangeNotifierProvider(
      create: (context) => InvesorsProjectListModel(
          ethAddress: _logInfo.etherAddress.toString()),
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
