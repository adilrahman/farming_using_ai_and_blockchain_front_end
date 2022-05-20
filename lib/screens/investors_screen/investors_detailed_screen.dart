import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_investors_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/widgets/crowd_funding_user_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';

class InvestorDetailedScreen extends StatefulWidget {
  InvestorDetailedScreen(
      {Key? key,
      required projectIndex,
      required projectModel,
      required Project project})
      : _projectIndex = projectIndex,
        _projectModel = projectModel,
        project = project,
        super(key: key);

  final int _projectIndex;
  final _projectModel;
  final project;

  @override
  State<InvestorDetailedScreen> createState() => _InvestorDetailedScreenState();
}

class _InvestorDetailedScreenState extends State<InvestorDetailedScreen> {
  bool showWithDrawDetails = false;

  @override
  Widget build(BuildContext context) {
    // var _projectModel = Provider.of<InvesorsProjectListModel>(context);

    final Project project =
        widget._projectModel.allProjects[widget._projectIndex];

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

    final _heading = "User name";
    final _data = "Adil rahman";
    final String _dummyDetails =
        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

    TextEditingController _enteredAmountController = TextEditingController();
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
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
                        style: TextStyle(
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
          Divider(
            color: Colors.black,
          ),
          Text(
            "Details",
            style: TextStyle(color: Colors.black),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.grey[700],
                      padding: EdgeInsets.all(20.0),
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
                                      data: "21", heading: "Days to go"),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  DetailTileRight(
                                      data: project.numberOfContributors
                                          .toString(),
                                      heading: "Contributors"),
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
                      padding: EdgeInsets.all(20.0),
                      child: SingleDetailChildRight(
                          heading: "land location",
                          data:
                              "pothukattil (house) angadipuram (po) malappuram (dt) kerala (st) - 679321"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.grey[700],
                      padding: EdgeInsets.all(20.0),
                      child: SingleDetailChildRight(
                          heading: "project details",
                          data: project.projectDescription),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                                        heading: "withdrawDetails", data: ""),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showWithDrawDetails =
                                              !showWithDrawDetails;
                                          withdrawDetails = widget._projectModel
                                              .currentProjectWithdrawDetails;
                                        });
                                        print(withdrawDetails.length);
                                      },
                                      icon: !showWithDrawDetails
                                          ? Icon(Icons.arrow_circle_down_sharp)
                                          : Icon(Icons.arrow_circle_up))
                                ],
                              ),
                              !showWithDrawDetails
                                  ? Container(
                                      child: Text("...."),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
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
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
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
                                                    Divider(),
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
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => Divider(
                                                      color: Colors.white,
                                                      thickness: 1.5,
                                                    ),
                                            itemCount: widget
                                                ._projectModel
                                                .currentProjectWithdrawDetails
                                                .length)
                                      ],
                                    ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    project.state == 2
                        ? ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Private Key",
                                  titlePadding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10, bottom: 10),
                                  contentPadding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10, bottom: 10),
                                  content: Container(
                                    child: TextField(),
                                  ),
                                  confirm: TextButton(
                                      onPressed: () {}, child: Text("confirm")),
                                  cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("cancel"),
                                  ));
                            },
                            child: Container(
                              child: Center(child: Text("WITHDRAW")),
                              width: double.infinity,
                              height: 50,
                            ),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    // project.state == 3
                    //     ? Container()
                    //     : ElevatedButton(
                    //         onPressed: () {
                    //           Get.defaultDialog(
                    //               barrierDismissible: false,
                    //               title: "Private Key",
                    //               titlePadding: EdgeInsets.only(
                    //                   top: 15, left: 10, right: 10, bottom: 10),
                    //               contentPadding: EdgeInsets.only(
                    //                   top: 15, left: 10, right: 10, bottom: 10),
                    //               content: Container(
                    //                 child: TextField(),
                    //               ),
                    //               confirm: TextButton(
                    //                   onPressed: () {
                    //                     _projectModel.cancelMyProject(
                    //                         project.contractAddress);
                    //                   },
                    //                   child: Text("confirm")),
                    //               cancel: TextButton(
                    //                 onPressed: () {
                    //                   Get.back();
                    //                 },
                    //                 child: Text("cancel"),
                    //               ));
                    //         },
                    //         child: Container(
                    //           child: Center(child: Text("CANCEL")),
                    //           width: double.infinity,
                    //           height: 50,
                    //         ),
                    //       )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.defaultDialog(
              barrierDismissible: false,
              title: "Invest",
              content: Container(
                child: Column(
                  children: [
                    const TextField(
                      style: TextStyle(),
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "Private Key"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _enteredAmountController,
                      style: TextStyle(),
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "Amount (min ${10} ETH)"),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              onConfirm: () {
                EthereumAddress adr = project.contractAddress;
                double _amount = double.parse(_enteredAmountController.text);
                widget._projectModel
                    .invest(projectContractAddress: adr, amount: _amount);
              },
              textConfirm: "invest",
              onCancel: () {},
              textCancel: "cancel");
        },
        label: Text("INVEST"),
        foregroundColor: Colors.white,
        icon: Icon(FontAwesomeIcons.ethereum),
        backgroundColor: Colors.blue,
        splashColor: AppColor.gradientSecond,
        elevation: 12,
        isExtended: true,
      ),
    );
  }
}

// Row(
//                                       children: [
//                                         Expanded(
//                                             flex: 2,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(10.0),
//                                               child: Text(
//                                                 "plant wind mill plant mill plant millplant wind mill plant mill plant mill",
//                                                 style: TextStyle(fontSize: 14),
//                                               ),
//                                             )),
//                                         Expanded(
//                                             flex: 2,
//                                             child: Text(
//                                               "12/2/2000",
//                                               style: TextStyle(fontSize: 14),
//                                             )),
//                                         Expanded(
//                                             flex: 1,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(10.0),
//                                               child: Text("1 ETH"),
//                                             )),
//                                       ],
//                                     );