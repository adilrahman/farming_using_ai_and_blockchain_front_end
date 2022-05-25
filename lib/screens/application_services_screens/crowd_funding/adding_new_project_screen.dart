import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/widgets/crowd_funding_user_screen_widgets.dart';

class addingNewProjectScreen extends StatelessWidget {
  addingNewProjectScreen({Key? key}) : super(key: key);

  final TextEditingController _projectNameEditingController =
      TextEditingController();
  final TextEditingController _projectDescriptionEditingController =
      TextEditingController();
  final TextEditingController _userPhoneNumberEditingController =
      TextEditingController();
  final TextEditingController _landLocationEditingController =
      TextEditingController();
  final TextEditingController _goalAmountEditingController =
      TextEditingController();
  final TextEditingController _minAmountEditingController =
      TextEditingController();
  final TextEditingController _durationEditingController =
      TextEditingController();
  final TextEditingController _privateKeyEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _projectModel = Provider.of<ProjectListModel>(context);

    final _hintText = "Title";
    final _icon = FontAwesomeIcons.ethereum;
    final String _suffixText = "ETH";
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              singleTextField(
                  titleEditingController: _projectNameEditingController,
                  hintText: "project name"),
              const SizedBox(height: 10),
              singleTextField(
                  titleEditingController: _userPhoneNumberEditingController,
                  hintText: "phone number"),
              const SizedBox(height: 10),
              singleTextField(
                  titleEditingController: _landLocationEditingController,
                  hintText: "Land Location"),
              const SizedBox(height: 10),
              TextFieldWithSuffix(
                  titleEditingController: _goalAmountEditingController,
                  suffixText: "ETH",
                  icon: FontAwesomeIcons.ethereum,
                  hintText: "Goal Amount"),
              const SizedBox(height: 10),
              TextFieldWithSuffix(
                  titleEditingController: _minAmountEditingController,
                  suffixText: "ETH",
                  icon: FontAwesomeIcons.ethereum,
                  hintText: "Minimum Amount"),
              const SizedBox(height: 10),
              TextFieldWithSuffix(
                  titleEditingController: _durationEditingController,
                  suffixText: "DAYS",
                  icon: Icons.date_range_outlined,
                  hintText: "Duration ( In Days )"),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              projectDescriptionField(
                  descriptionEditingController:
                      _projectDescriptionEditingController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                      barrierDismissible: false,
                      title: "Private Key",
                      titlePadding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      contentPadding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      content: Container(
                        child: TextField(
                          controller: _privateKeyEditingController,
                        ),
                      ),
                      confirm: TextButton(
                          onPressed: () {
                            _createNewproject(_projectModel.createNewProject,
                                _privateKeyEditingController.text);
                            Get.snackbar("created", "new project created");
                            Get.back();
                          },
                          child: Text("confirm")),
                      cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("cancel"),
                      ));
                },
                child: Container(
                  child: Center(child: Text("CREATE")),
                  width: double.infinity,
                  height: 50,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _createNewproject(createProject, privateKey) async {
    NewProjectModel _newProject = NewProjectModel(
        projectName: _projectNameEditingController.text,
        phoneNumber: _userPhoneNumberEditingController.text,
        landLocation: _landLocationEditingController.text,
        projectDescription: _projectDescriptionEditingController.text,
        goalAmount: _goalAmountEditingController.text,
        minimumContribution: _minAmountEditingController.text,
        duration: _durationEditingController.text,
        privateKey: _privateKeyEditingController.text);
    createProject(_newProject, privateKey);
    // return true;
  }
}
