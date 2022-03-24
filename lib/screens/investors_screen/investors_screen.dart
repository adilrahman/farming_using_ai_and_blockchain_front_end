import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'investors_detailed_screen.dart';

class InvestorsScreen extends StatelessWidget {
  const InvestorsScreen({Key? key}) : super(key: key);
  final _username = "Username";
  final _projectname = "project name";
  final _description =
      "it is good description though it is good description though it is good description though";
  final _postedDate = "1 day left";
  final _totalAmount = "5";
  final _percentageOfCompletion = 0.6;
  final _percentageOfCompletionInText = "60%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColor.gradientFirst, AppColor.gradientSecond])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // username and settings button
            _UserNameSection(username: _username),
            const SizedBox(
              height: 10,
            ),
            //search bar
            //project views
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "farming projects",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColor.homePageContainerTextBig),
                  ),
                  Divider(
                    color: AppColor.homePageTitle,
                  ),
                ],
              ),
            ),

            //farming projects
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  print("object");
                  Get.snackbar("title", "message");
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.homePageBackground,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(70),
                            topLeft: Radius.circular(70))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: OverflowBox(
                      child: ListView.builder(
                        // itemCount: 20,
                        itemBuilder: (context, index) => FarmingProjectListView(
                            projectname: _projectname,
                            postedDate: _postedDate,
                            description: _description,
                            totalAmount: _totalAmount,
                            percentageOfCompletion: _percentageOfCompletion,
                            percentageOfCompletionInText:
                                _percentageOfCompletionInText),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmingProjectListView extends StatelessWidget {
  const FarmingProjectListView({
    Key? key,
    required String projectname,
    required String postedDate,
    required String description,
    required String totalAmount,
    required double percentageOfCompletion,
    required String percentageOfCompletionInText,
  })  : _projectname = projectname,
        _postedDate = postedDate,
        _description = description,
        _totalAmount = totalAmount,
        _percentageOfCompletion = percentageOfCompletion,
        _percentageOfCompletionInText = percentageOfCompletionInText,
        super(key: key);

  final String _projectname;
  final String _postedDate;
  final String _description;
  final String _totalAmount;
  final double _percentageOfCompletion;
  final String _percentageOfCompletionInText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(InvestorDetailedScreen(),
            transition: Transition.downToUp, duration: Duration(seconds: 1));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(2, 5),
                  color: AppColor.gradientSecond.withOpacity(0.9))
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(33),
                bottomLeft: Radius.circular(33),
                topLeft: Radius.circular(33),
                bottomRight: Radius.circular(33)),
            gradient: LinearGradient(colors: [
              AppColor.gradientFirst.withOpacity(0.9),
              AppColor.gradientSecond.withOpacity(0.9),
            ])),
        margin: const EdgeInsets.symmetric(vertical: 9),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: double.infinity,
              height: 175,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          _projectname,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 27),
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.timer,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          _postedDate,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(33)),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: LinearPercentIndicator(
                        animation: true,
                        trailing: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_totalAmount),
                            const Icon(
                              FontAwesomeIcons.ethereum,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                        curve: Curves.linear,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: _percentageOfCompletion,
                        center: Text(_percentageOfCompletionInText),
                        progressColor: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserNameSection extends StatelessWidget {
  const _UserNameSection({
    Key? key,
    required String username,
  })  : _username = username,
        super(key: key);

  final String _username;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const Icon(
            Icons.person_outline,
            size: 25,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            _username,
            style: TextStyle(
                color: AppColor.homePageContainerTextBig,
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              Get.to(
                SettingsScreen(),
                transition: Transition.circularReveal,
                duration: const Duration(seconds: 2),
              );
            },
            icon: const Icon(Icons.settings_outlined),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
