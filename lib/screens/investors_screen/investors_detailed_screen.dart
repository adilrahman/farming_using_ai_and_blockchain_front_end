import 'dart:developer';

import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/contributors_list_view_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/widgets/crowd_funding_user_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class InvestorDetailedScreen extends StatefulWidget {
  const InvestorDetailedScreen(
      {Key? key,
      required projectIndex,
      required projectModel,
      required Project project})
      : _projectIndex = projectIndex,
        _projectModel = projectModel,
        _project = project,
        super(key: key);

  final int _projectIndex;
  final _projectModel;
  final _project;

  @override
  State<InvestorDetailedScreen> createState() => _InvestorDetailedScreenState();
}

class _InvestorDetailedScreenState extends State<InvestorDetailedScreen> {
  bool showWithDrawDetails = false;
  double totalWithdraw = 0.0;

  @override
  Widget build(BuildContext context) {
    //project total collected amount

    double projetContractBalance = double.parse(
        widget._projectModel.allProjects[widget._projectIndex].currentBalance);

    log(projetContractBalance.toString());
    final Project project = widget._project;

    // to get the withdraw details of the specific project
    widget._projectModel
        .getWithdrawDetails(projectAddress: project.contractAddress);

    var withdrawDetails;

    final double _percentage = double.parse(project.currentBalance) /
                double.parse(project.goalAmount) >
            1
        ? 1
        : double.parse(project.currentBalance) /
            double.parse(project.goalAmount);

    final String _percentageOfCompletionInText =
        (_percentage * 100).toString() + "%";

    TextEditingController _enteredAmountController = TextEditingController();
    TextEditingController _privateKeyController = TextEditingController();
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
                                  InkWell(
                                    onLongPress: () async {
                                      await widget._projectModel
                                          .getProjectContributorsList(
                                              projectAddress:
                                                  project.contractAddress);
                                      await widget._projectModel
                                          .getMyContributionAmount(
                                              project.contractAddress);
                                      Get.to(ContributorsListViewScreen(
                                          myContribution: widget
                                              ._projectModel.myContribution,
                                          details: widget._projectModel
                                              .contributorsListOfProject));
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
                    Container(
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: SingleDetailChildRight(
                                        heading: "withdraw details", data: ""),
                                  ),
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
                                                              "  ${widget._projectModel.currentProjectWithdrawDetails[index]["amount"].toString()} ETH")
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
                                              style: const TextStyle(
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
                    (project.state == 3 && project.projectClosing) ||
                            (project.state == 4) // state 2 -> successful
                        ? ElevatedButton(
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
                                      controller: _privateKeyController,
                                    ),
                                  ),
                                  confirm: TextButton(
                                      onPressed: () {
                                        widget._projectModel.setApproval(
                                            project.contractAddress,
                                            _privateKeyController.text);
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
                              child: const Center(child: Text("Approval")),
                              width: double.infinity,
                              height: 50,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: project.state != 0
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Get.defaultDialog(
                    barrierDismissible: false,
                    title: "Invest",
                    content: Container(
                      child: Column(
                        children: [
                          TextField(
                            controller: _privateKeyController,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Private Key"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _enteredAmountController,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Amount (min ${10} ETH)"),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    onConfirm: () {
                      EthereumAddress adr = project.contractAddress;
                      double _amount =
                          double.parse(_enteredAmountController.text);
                      String _privateKey = _privateKeyController.text;
                      widget._projectModel.invest(
                          projectContractAddress: adr,
                          amount: _amount,
                          privateKey: _privateKey);
                    },
                    textConfirm: "invest",
                    onCancel: () {},
                    textCancel: "cancel");
              },
              label: const Text("INVEST"),
              foregroundColor: Colors.white,
              icon: const Icon(FontAwesomeIcons.ethereum),
              backgroundColor: Colors.blue,
              splashColor: AppColor.gradientSecond,
              elevation: 12,
              isExtended: true,
            ),
    );
  }
}
