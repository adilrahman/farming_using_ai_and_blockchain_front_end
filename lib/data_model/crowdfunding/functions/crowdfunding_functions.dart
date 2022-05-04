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
  final String _privateKey =
      "a2e3be7520c7fcc66922cab1baae192a809a4e2ae085ac50dfb3dc3d94d5e0c8";

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

  static const List<List> PROJECT_STATE = [
    ["Fundraising", Colors.green],
    ["Expired", Colors.red],
    ["Successful", Colors.grey],
    ["Cancelled", Colors.yellow]
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
    await getMyCurrentProject();
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

    //TODO 1 :- initializing contract functions
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
          contractAddress: myProjectsAddress[i],
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
      notifyListeners();
    }
  }

  getMyCurrentProject() async {
    List<dynamic> credDetails = await getCredentials(_privateKey);
    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];
    var myProjectsAddress = await _client!.call(
        sender: _ownAddress,
        contract: _contractOfFactory,
        function: _getMyprojects,
        params: []);

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
          contractAddress: myProjectsAddress[i],
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
      myProjects = List.from(myProjects.reversed);
      notifyListeners();
    }
  }

  createNewProject(NewProjectModel _newProject) async {
    List<dynamic> credDetails = await getCredentials(_privateKey);
    String _projectName = _newProject.projectName;
    String _projectDescription = _newProject.projectDescription;
    int _goalAmount = int.parse(_newProject.goalAmount);
    int _minimunContribution = int.parse(_newProject.minimumContribution);

    int _durationInDays = int.parse(_newProject.duration);

    String _creatorName = "adil rahman";
    String _phoneNumber = _newProject.phoneNumber;

    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    // var totalProjectCount = await _client!.call(
    //     contract: _contractOfFactory, function: _returnAllProjects, params: []);
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
    await getMyCurrentProject();
  }

  cancelMyProject(_projectContractAddress) async {
    print("canceling canceling canceling canceling canceling canceling");
    List<dynamic> credDetails = await getCredentials(_privateKey);

    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"),
        _projectContractAddress);

    _cancelTheProject = _tmpContract.function("cancelTheProject");

    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _tmpContract,
          function: _cancelTheProject,
          parameters: [],
        ));
    getMyCurrentProject();
    notifyListeners();
  }
}
