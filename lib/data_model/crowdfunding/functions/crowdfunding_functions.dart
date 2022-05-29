import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class ProjectListModel extends ChangeNotifier {
  var username;
  var ethAddress;
  List<Project> myProjects = []; // used to store fethced projects
  List<dynamic> currentProjectWithdrawDetails = [];
  List<dynamic> contributorsListOfProject = [];
  final String _rpcUrl = "http://192.168.43.135:7545";
  final String _wsUrl = "ws://192.168.43.135:7545";
  final String _privateKey =
      "d383106d282b65415940baa3680a54aca0db3005d8d759fbf871a56699959eac";

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

  final List<List> PROJECT_STATE = [
    ["Fundraising", Colors.green],
    ["Expired", Colors.red],
    ["Successful", Colors.grey],
    ["Cancelled", Colors.yellow],
    ["Completed", Colors.orangeAccent],
    ["Closed", Colors.red]
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

    await retriveUserData();
    await getAbi();
    await getDeployedContract();
    await getMyCurrentProject();
  }

  retriveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username")!;
    ethAddress = prefs.getString("ethAddress")!;
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Crowdfunding.json");

    var jsonAbi = await jsonDecode(abiStringFile);
    _abiOfFactory = await jsonEncode(jsonAbi["abi"]);

    _contractAddressOfFactory =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);

    abiStringFile = await rootBundle.loadString("src/abis/Project.json");
    jsonAbi = await jsonDecode(abiStringFile);
    _abiOfProject = await jsonEncode(jsonAbi["abi"]);
    print(_abiOfProject);
  }

  Future<List<dynamic>> getCredentials(_privateKey) async {
    var _credentials = EthPrivateKey.fromHex(_privateKey);
    var _ownAddress = await _credentials.extractAddress();

    return [_credentials, _ownAddress];
  }

  getDeployedContract() async {
    _contractOfFactory = DeployedContract(
        ContractAbi.fromJson(_abiOfFactory!, "Crowdfunding"),
        _contractAddressOfFactory);

    _createNewProject = _contractOfFactory.function("startProject");
    _countOfProjects = _contractOfFactory.function("numberOfProjects");
    _returnAllProjects = _contractOfFactory.function("returnAllProjects");
    _getMyprojects = _contractOfFactory.function("getMyprojects");

    var totalProjectCount = await _client!.call(
        contract: _contractOfFactory, function: _countOfProjects, params: []);
  }

  getMyCurrentProject() async {
    List<dynamic> credDetails = await getCredentials(_privateKey);
    var _credentials = credDetails[0];
    var _ownAddress = EthereumAddress.fromHex(ethAddress);
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

      var _isProjectClosing = _tmpContract.function("isProjectClosing");

      var _isProjectClosingResult = await _client!.call(
          contract: _tmpContract, function: _isProjectClosing, params: []);

      // print(
      // "_isProjectClosedResult _isProjectClosedResult_isProjectClosedResult _isProjectClosedResult _isProjectClosedResult _isProjectClosedResult _isProjectClosedResult ${_isProjectClosingResult[0] == true}");

      var _projectSummary = await _client!
          .call(contract: _tmpContract, function: _getSummary, params: []);

      String _goalAmount_tmp =
          convertionWeiToEth(false, double.parse(_projectSummary[6].toString()))
              .toString();

      String _minimunContribution_tmp =
          convertionWeiToEth(false, double.parse(_projectSummary[8].toString()))
              .toString();

      var _currentBalance =
          convertionWeiToEth(false, double.parse(_projectSummary[7].toString()))
              .toString();

      var millis = int.parse(_projectSummary[3].toString());
      var dt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);

// 12 Hour format:
      var d12 =
          DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

// 24 Hour format:
      var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00

      dynamic expired = DateFormat('yyyy/MM/dd').format(dt);
      final rightNow = DateTime.now();
      var dateDate = expired.split(r"/");

      expired = DateTime(int.parse(dateDate[0]), int.parse(dateDate[1]),
          int.parse(dateDate[2]));

      final difference = expired.difference(rightNow).inDays;

      Project _tmpProject = Project(
          contractAddress: myProjectsAddress[i],
          creator: _projectSummary[0].toString(),
          creatorName: _projectSummary[1].toString(),
          phoneNumber: _projectSummary[2].toString(),
          raiseBy: d12.toString(),
          projectName: _projectSummary[4].toString(),
          projectDescription: _projectSummary[5].toString(),
          goalAmount: _goalAmount_tmp,
          currentBalance: _currentBalance,
          minimunContribution: _minimunContribution_tmp,
          state: int.parse(_projectSummary[9].toString()),
          numberOfContributors: int.parse(_projectSummary[10].toString()),
          expiredAtInDays: difference.toString(),
          landLocation: _projectSummary[11].toString(),
          projectClosing: _isProjectClosingResult[0]);

      myProjects.add(_tmpProject);

      myProjects = List.from(myProjects.reversed);
      notifyListeners();
    }
  }

  double convertionWeiToEth(bool isAmountEth, double _amount) {
    const double one_eth_in_wei = 1000000000000000000;

    if (isAmountEth) {
      return _amount * one_eth_in_wei;
    }

    return _amount / one_eth_in_wei;
  }

  createNewProject(NewProjectModel _newProject, String privateKey) async {
    List<dynamic> credDetails = await getCredentials(privateKey);
    String _projectName = _newProject.projectName;
    String _projectDescription = _newProject.projectDescription;
    double _goalAmount = double.parse(_newProject.goalAmount);
    double _minimunContribution = double.parse(_newProject.minimumContribution);
    String _landlocation = _newProject.landLocation.toString();

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
              BigInt.from(convertionWeiToEth(true, _goalAmount)),
              BigInt.from(convertionWeiToEth(true, _minimunContribution)),
              BigInt.from(_durationInDays),
              _creatorName,
              _phoneNumber,
              _landlocation
            ]));
    await getMyCurrentProject();
  }

  cancelMyProject(_projectContractAddress, privateKey) async {
    List<dynamic> credDetails = await getCredentials(privateKey);

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

  withAmountdrawWithDetails({
    required projectAddress,
    required privateKey,
    required amount,
    required details,
  }) async {
    List<dynamic> credDetails = await getCredentials(privateKey);
    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"), projectAddress);

    _withDraw = _tmpContract.function("withDraw");

    amount = double.parse(amount);
    amount = convertionWeiToEth(true, amount); // converted to wei
    amount = BigInt.from(amount);

    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _tmpContract,
          function: _withDraw,
          parameters: [amount, details.toString()],
          from: EthereumAddress.fromHex(_ownAddress.toString()),
        ));
  }

  getWithdrawDetails({required projectAddress}) async {
    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"),
        EthereumAddress.fromHex(projectAddress.toString()));

    _returnAllWithDrawDetails =
        _tmpContract.function("returnAllWithDrawDetails");

    var withdrawDetails = await _client!.call(
        contract: _tmpContract,
        function: _returnAllWithDrawDetails,
        params: []);

    currentProjectWithdrawDetails.clear();
    for (var item in withdrawDetails[0]) {
      item[0] = convertionWeiToEth(false, double.parse(item[0].toString()));
      item[2] = int.parse(item[2].toString());

      item[2] = unixEpochToReadableText(item[2]);

      currentProjectWithdrawDetails
          .add({"date": item[2], "details": item[1], "amount": item[0]});
    }
  }

  String unixEpochToReadableText(int epoch) {
    var millis = epoch;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
    var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return d12.toString();
  }

  makeProjectComplete(projectAddress, privateKey) async {
    List<dynamic> credDetails = await getCredentials(privateKey);

    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"), projectAddress);

    var _makeProjectComplete = _tmpContract.function("setProjectClosing");

    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _tmpContract,
          function: _makeProjectComplete,
          parameters: [],
        ));
    getMyCurrentProject();
    notifyListeners();
  }

  getProjectContributorsList({required projectAddress}) async {
    contributorsListOfProject.clear();

    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"),
        EthereumAddress.fromHex(projectAddress.toString()));

    var _getContributorsList = _tmpContract.function("getContributorsList");

    var contributorsList = await _client!.call(
      contract: _tmpContract,
      function: _getContributorsList,
      params: [],
    );

    for (int i = 0; i < contributorsList[1].length; i++) {
      contributorsList[1][i] = convertionWeiToEth(
          false, double.parse(contributorsList[1][i].toString()));
      contributorsListOfProject.add({
        "address": contributorsList[0][i],
        "amount": contributorsList[1][i]
      });
    }
  }
}
