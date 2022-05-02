import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';

class ProjectListModel extends ChangeNotifier {
  List<Project> myProjects = []; // used to store fethced projects
  final String _rpcUrl = "http://192.168.43.135:7545";
  final String _wsUrl = "ws://192.168.43.135:7545";
  // final String _privateKey =
  //     "0856c09520195c34cb55d25171f813d6401eedfdd7950f4446a0aeadf7718710";

  Web3Client? _client;
  String? _abiOfFactory;
  String? _abiOfProject;
  var _contractAddressOfFactory;
  var _credentials;
  var _ownAddress;
  var _contractOfFactory;

  //All functionalities initialized

  //Crowdfunding contract functions
  var _createNewProject;
  var _countOfProjects; //function returns total number of projects created so far
  var _returnAllProjects; //function return all projects addresses as Project[]
  var _getMyprojects; // return my project only

  //Project contract functions
  var _contibute;
  var _contributorsCount;
  var _checkImAContributor;
  var _withDrawAllAmount;
  var _withDraw;
  var _cancelTheProject;
  var _getRefund;
  var _returnAllWithDrawDetails;
  var _getSummary;

  final List<String> PROJECT_STATE = [
    "Fundraising",
    "Expired",
    "Successful",
    "Cancelled"
  ];

  ProjectListModel() {
    initiateState();
  }
  initiateState() async {
    _client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () => IOWebSocketChannel.connect(_wsUrl).cast<String>(),
    );
    await getAbi();
    await getDeployedContract();
    await getAllCurrentProject();
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Crowdfunding.json");
    // print(abiStringFile);

    var jsonAbi = await jsonDecode(abiStringFile);
    _abiOfFactory = await jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);
    _contractAddressOfFactory =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    // print(_contractAddress);
    abiStringFile = await rootBundle.loadString("src/abis/Project.json");
    jsonAbi = await jsonDecode(abiStringFile);
    _abiOfProject = await jsonEncode(jsonAbi["abi"]);
    print(_abiOfProject);
  }

  Future<List<dynamic>> getCredentials(_privateKey) async {
    var _credentials = EthPrivateKey.fromHex(_privateKey);
    var _ownAddress = await _credentials.extractAddress();
    // print(_credentials);

    return [_credentials, _ownAddress];
  }

  getDeployedContract() async {
    // print("==============================>>>>>>>>> ");
    _contractOfFactory = DeployedContract(
        ContractAbi.fromJson(_abiOfFactory!, "Crowdfunding"),
        _contractAddressOfFactory);

    //TODO initializing contract functions
    _createNewProject = _contractOfFactory.function("startProject");
    _countOfProjects = _contractOfFactory.function("numberOfProjects");
    _returnAllProjects = _contractOfFactory.function("returnAllProjects");
    _getMyprojects = _contractOfFactory.function("getMyprojects");

    var totalProjectCount = await _client!.call(
        contract: _contractOfFactory, function: _countOfProjects, params: []);
    print("==================>>>>>>>>> ${totalProjectCount}");
  }

  getAllCurrentProject() async {
    var myProjectsAddress = await _client!.call(
        contract: _contractOfFactory, function: _returnAllProjects, params: []);

    myProjectsAddress =
        myProjectsAddress[0]; // coz it return a 2d array initially

    myProjects.clear();
    for (int i = 0; i < myProjectsAddress.length; i++) {
      var _tmpContract = DeployedContract(
          ContractAbi.fromJson(_abiOfProject!, "Project"),
          myProjectsAddress[i]);

      _getSummary = _tmpContract.function("getSummary");

      var _projectSummary = await _client!
          .call(contract: _tmpContract, function: _getSummary, params: []);

      Project _tmpProject = Project(
          creator: _projectSummary[0].toString(),
          creatorName: _projectSummary[1].toString(),
          phoneNumber: _projectSummary[2].toString(),
          raiseBy: _projectSummary[3].toString(),
          projectName: _projectSummary[4].toString(),
          projectDescription: _projectSummary[5].toString(),
          goalAmount: _projectSummary[6].toString(),
          currentBalance: _projectSummary[7].toString(),
          minimunContribution: _projectSummary[8].toString(),
          state: int.parse(_projectSummary[9].toString()),
          numberOfContributors: int.parse(_projectSummary[10].toString()));

      myProjects.add(_tmpProject);

      print(PROJECT_STATE[_tmpProject.state]);
    }
  }

  createNewProject(NewProjectModel _newProject) async {
    List<dynamic> credDetails = await getCredentials(
        "22a5f3e5f17a92ebd08abeb858f3974ac29d8dd1f5b875ce19096735b93a1117");
    String _projectName = _newProject.projectName;
    String _projectDescription = _newProject.projectDescription;
    int _goalAmount = int.parse(_newProject.goalAmount);
    int _minimunContribution = int.parse(_newProject.minimumContribution);

    int _durationInDays = int.parse(_newProject.duration);

    String _creatorName = "adil rahman";
    String _phoneNumber = _newProject.phoneNumber;

    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    var totalProjectCount = await _client!.call(
        contract: _contractOfFactory, function: _returnAllProjects, params: []);
    //  print("==================>>>>>>>>> ${totalProjectCount[0]}");
    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contractOfFactory,
            function: _createNewProject,
            parameters: [
              _projectName,
              _projectDescription,
              BigInt.from(_goalAmount),
              BigInt.from(_minimunContribution),
              BigInt.from(_durationInDays),
              _creatorName,
              _phoneNumber
            ]));
    await getAllCurrentProject();
  }
}
