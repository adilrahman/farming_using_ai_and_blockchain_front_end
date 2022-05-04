import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/detailed_project_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FarmingProjectListView extends StatelessWidget {
  const FarmingProjectListView({
    Key? key,
    required int projectIndex,
    required projectModel,
    required String projectname,
    required String postedDate,
    required String description,
    required String totalAmount,
    required double percentageOfCompletion,
    required String percentageOfCompletionInText,
    required String projectState,
    required stateColor,
  })  : _projectModel = projectModel,
        _projectIndex = projectIndex,
        _projectname = projectname,
        _postedDate = postedDate,
        _description = description,
        _totalAmount = totalAmount,
        _percentageOfCompletion = percentageOfCompletion,
        _percentageOfCompletionInText = percentageOfCompletionInText,
        _projectState = projectState,
        _stateColor = stateColor,
        super(key: key);

  final String _projectname;
  final String _postedDate;
  final String _description;
  final String _totalAmount;
  final double _percentageOfCompletion;
  final String _percentageOfCompletionInText;
  final String _projectState;
  final int _projectIndex;
  final _projectModel;
  final _stateColor;

  @override
  Widget build(BuildContext context) {
    final Project project = _projectModel.myProjects[_projectIndex];
    final String _projectname = project.projectName;
    final String _postedDate = project.raiseBy;
    final String _description = project.projectDescription;
    final String _totalAmount = project.goalAmount;
    final double _percentage = double.parse(project.currentBalance) /
                double.parse(project.goalAmount) >
            1
        ? 1
        : double.parse(project.currentBalance) /
            double.parse(project.goalAmount);

    print(
        "_percentage_percentage_percentage_percentage_percentage_percentage_percentage => ${_percentage}");
    final double _percentageOfCompletion = _percentage;
    final String _percentageOfCompletionInText =
        (_percentage * 100).toString() + " %";
    return InkWell(
      onTap: () {
        Get.to(
            DetailedProjectView(
              projectIndex: _projectIndex,
              projectModel: _projectModel,
            ),
            transition: Transition.downToUp,
            duration: Duration(seconds: 1));
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
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                        child: Container(
                      width: 200,
                      height: 35,
                      decoration: BoxDecoration(color: _stateColor),
                      child: Center(
                        child: Text(
                          _projectState,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    )),
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
