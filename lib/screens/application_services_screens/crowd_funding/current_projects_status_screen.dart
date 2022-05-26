import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/widgets/crowd_funding_user_screen_widgets.dart';

class currentProjectsStatusScreen extends StatelessWidget {
  const currentProjectsStatusScreen({Key? key}) : super(key: key);

  final _percentageOfCompletion = 0.6;
  final _percentageOfCompletionInText = "60%";

  @override
  Widget build(BuildContext context) {
    var _projectModel = Provider.of<ProjectListModel>(context);

    return Container(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Current Projects (${_projectModel.myProjects.length})",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _projectModel.getMyCurrentProject();
                Get.snackbar("title", "message");
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.homePageBackground,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(70))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: OverflowBox(
                    child: ListView.builder(
                      itemCount:
                          _projectModel.myProjects.length, //total project count
                      itemBuilder: (context, index) => FarmingProjectListView(
                        projectModel: _projectModel,
                        projectIndex: index,
                        projectname:
                            _projectModel.myProjects[index].projectName,
                        postedDate: _projectModel.myProjects[index].raiseBy,
                        description:
                            _projectModel.myProjects[index].projectDescription,
                        totalAmount: _projectModel.myProjects[index].goalAmount,
                        percentageOfCompletion: _percentageOfCompletion,
                        percentageOfCompletionInText:
                            _percentageOfCompletionInText,
                        projectState: _projectModel.PROJECT_STATE[
                            // coz the PROJECT_STATE  is a static varibale
                            _projectModel.myProjects[index].state][0],
                        stateColor: _projectModel.PROJECT_STATE[
                            _projectModel.myProjects[index].state][1],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
