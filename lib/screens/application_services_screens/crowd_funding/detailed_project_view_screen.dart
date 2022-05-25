import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/contributors_list_view_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/widgets/crowd_funding_user_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

final TextEditingController _privateKeyTextController = TextEditingController();
final TextEditingController _amountTextController = TextEditingController();
final TextEditingController _withdrawDetailsTextController =
    TextEditingController();

class DetailedProjectView extends StatefulWidget {
  DetailedProjectView({Key? key, required projectIndex, required projectModel})
      : _projectIndex = projectIndex,
        _projectModel = projectModel,
        super(key: key);

  final int _projectIndex;
  final _projectModel;

  @override
  State<DetailedProjectView> createState() => _DetailedProjectViewState();
}

// withdraw box toggile flag
bool showWithDrawDetails = false;
double totalWithdraw = 0.0;

class _DetailedProjectViewState extends State<DetailedProjectView> {
  @override
  Widget build(BuildContext context) {
    print(
        "ENNNNNNNNNNNNNNNNNNNNNNNNNTTTTTTTTTTTTTTTTTTTTTTTTERRRRRRRRRRRRRRRRRRRRRRRRRRRRR4444902 => ${widget._projectModel.myProjects.length}");
    //project total collected amount
    double projetContractBalance = double.parse(
        widget._projectModel.myProjects[widget._projectIndex].currentBalance);

    final Project project =
        widget._projectModel.myProjects[widget._projectIndex];

    // project current contract balance

    // to get the withdraw details of the specific project
    widget._projectModel
        .getWithdrawDetails(projectAddress: project.contractAddress);

    final double _percentage = double.parse(project.currentBalance) /
                double.parse(project.goalAmount) >
            1
        ? 1
        : double.parse(project.currentBalance) /
            double.parse(project.goalAmount);

    final String _percentageOfCompletionInText =
        (_percentage * 100).toString() + "%";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.gradientSecond,
      ),
      backgroundColor: AppColor.homePageBackground,
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  project.projectName, //project name
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                      child: Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                        color: widget._projectModel.PROJECT_STATE[project.state]
                            [1]),
                    child: Center(
                      child: Text(
                        widget._projectModel.PROJECT_STATE[project.state]
                            [0], //PROJECT STATE
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                    ),
                  )),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                gradient: LinearGradient(
                    colors: [AppColor.gradientFirst, AppColor.gradientSecond])),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
          ),
          const Text(
            "Details",
            style: TextStyle(color: Colors.black),
          ),
          const Divider(
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.grey[700],
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: Column(
                                children: [
                                  DetailTileRight(
                                      data: _percentageOfCompletionInText,
                                      heading: "Funded"),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  DetailTileRight(
                                      data: project.expiredAtInDays.toString(),
                                      heading: "Days to go"),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  // contribution side box with onpress event
                                  InkWell(
                                    onLongPress: () async {
                                      await contributionBoxOnpress(
                                          project: project);
                                    },
                                    child: DetailTileRight(
                                        data: project.numberOfContributors
                                            .toString(),
                                        heading: "Contributors"),
                                  ),
                                ],
                              ))),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  child: Column(
                                children: [
                                  SingleDetailChildRight(
                                      heading: "farmer name",
                                      data: project.creatorName),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleDetailChildRight(
                                      heading: "phone number",
                                      data: project.phoneNumber),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleDetailChildRight(
                                      heading: "goal amount",
                                      data: "${project.goalAmount} ETH"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleDetailChildRight(
                                      heading: "minimum contribution",
                                      data:
                                          "${project.minimunContribution} ETH"),
                                ],
                              ))),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // land location box
                    Container(
                      //
                      color: Colors.grey[700],
                      padding: const EdgeInsets.all(20.0),
                      child: SingleDetailChildRight(
                          heading: "land location", data: project.landLocation),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // project details box
                    Container(
                      color: Colors.grey[700],
                      padding: const EdgeInsets.all(20.0),
                      child: SingleDetailChildRight(
                          heading: "project details",
                          data: project.projectDescription),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // withdraw details box
                    Container(
                        color: Colors.grey[700],
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SingleDetailChildRight(
                                      heading: "withdrawDetails ",
                                      data: "",
                                    ),
                                  ),

                                  // withdraw details toggle button
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showWithDrawDetails =
                                              !showWithDrawDetails;

                                          // it calculate the total withdraw amount
                                          totalWithdraw = 0;
                                          int n = widget
                                              ._projectModel
                                              .currentProjectWithdrawDetails
                                              .length;

                                          for (int i = 0; i < n; i++) {
                                            totalWithdraw += widget
                                                    ._projectModel
                                                    .currentProjectWithdrawDetails[
                                                i]["amount"];
                                          }
                                        });
                                      },
                                      icon: !showWithDrawDetails
                                          ? const Icon(
                                              Icons.arrow_circle_down_sharp)
                                          : const Icon(Icons.arrow_circle_up))
                                ],
                              ),
                              !showWithDrawDetails
                                  ? Container(
                                      child: const Text("...."),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "DATE",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "DETAILS",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "AMOUNT",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      // details
                                                      child: Text(widget
                                                          ._projectModel
                                                          .currentProjectWithdrawDetails[
                                                              index]["details"]
                                                          .toString()),
                                                    ),
                                                    const Divider(),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              //date
                                                              child: Text(widget
                                                                  ._projectModel
                                                                  .currentProjectWithdrawDetails[
                                                                      index]
                                                                      ["date"]
                                                                  .toString())),
                                                          Text(
                                                              "${widget._projectModel.currentProjectWithdrawDetails[index]["amount"].toString()} ETH")
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                      color: Colors.white,
                                                      thickness: 1.5,
                                                    ),
                                            itemCount: widget
                                                ._projectModel
                                                .currentProjectWithdrawDetails
                                                .length),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          color: Colors.blue,
                                          thickness: 1.5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "BALANCE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              " = ${(projetContractBalance - totalWithdraw).toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            const Icon(
                                              FontAwesomeIcons.ethereum,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // withdraw amount with withdraw details button
                    project.state == 2 // state 2 -> successful
                        ? ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Withdraw",
                                  titlePadding: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10, bottom: 10),
                                  contentPadding: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10, bottom: 10),
                                  content: Container(
                                    child: Column(
                                      children: [
                                        DialogeTextField(
                                            textController:
                                                _privateKeyTextController,
                                            hintText: "private key"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DialogeTextField(
                                            textController:
                                                _amountTextController,
                                            hintText: "amount"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DialogeTextField(
                                            textController:
                                                _withdrawDetailsTextController,
                                            hintText: "withdraw deatils"),
                                      ],
                                    ),
                                  ),
                                  confirm: TextButton(
                                      onPressed: () {
                                        withdrawWithDetails(
                                            projectAddress:
                                                project.contractAddress);
                                      },
                                      child: const Text("confirm")),
                                  cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("cancel"),
                                  ));
                            },
                            child: Container(
                              child:
                                  const Center(child: Text("WITHDRAW AMOUNT")),
                              width: double.infinity,
                              height: 50,
                            ),
                          )
                        : Container(),

                    const SizedBox(
                      height: 20,
                    ),

                    //cancel project button
                    project.state == 3 // state 3 -> cancelled state
                        ? Container()
                        : ElevatedButton(
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
                                      controller: _privateKeyTextController,
                                    ),
                                  ),
                                  confirm: TextButton(
                                      onPressed: () {
                                        widget._projectModel.cancelMyProject(
                                            project.contractAddress,
                                            _privateKeyTextController.text);
                                      },
                                      child: Text("confirm")),
                                  cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("cancel"),
                                  ));
                            },
                            child: Container(
                              child: const Center(child: Text("CANCEL")),
                              width: double.infinity,
                              height: 50,
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// withdraw amount with use case text button onpress method
  withdrawWithDetails({required projectAddress}) {
    final _privateKey = _privateKeyTextController.text;
    final _amount = _amountTextController.text;
    final _details = _withdrawDetailsTextController.text;
    widget._projectModel.withAmountdrawWithDetails(
      projectAddress: projectAddress,
      privateKey: _privateKey,
      amount: _amount,
      details: _details,
    );
  }

  //contribution onpress button for showing details of investors
  contributionBoxOnpress({required project}) async {
    await widget._projectModel
        .getProjectContributorsList(projectAddress: project.contractAddress);
    Get.to(ContributorsListViewScreen(
        details: widget._projectModel.contributorsListOfProject));
  }
}
