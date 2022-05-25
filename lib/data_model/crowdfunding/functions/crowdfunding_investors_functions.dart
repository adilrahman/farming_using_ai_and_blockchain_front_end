import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/project_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';

class InvesorsProjectListModel extends ChangeNotifier {
  List<Project> allProjects = []; // used to store all fethced projects
  List<Project> myProjects = []; // used to store only invested projects
  List<dynamic> contributorsListOfProject = [];
  List<dynamic> currentProjectWithdrawDetails = [];
  final String _rpcUrl = "http://192.168.43.135:7545";
  final String _wsUrl = "ws://192.168.43.135:7545";
  final String _privateKey =
      "71df7b8ce21c390690533fd31a27403f77a4529cb9da37c2b8bd957a7d87c927";

  final ethAddress;

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
  var _getMyContributedProjects;

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
    ["Cancelled", Colors.yellow]
  ];

  bool isLoading = false;
  InvesorsProjectListModel({required this.ethAddress}) {
    initiateState();
  }

  initiateState() async {
    _client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () => IOWebSocketChannel.connect(_wsUrl).cast<String>(),
    );
    isLoading = true;
    await getAbi();
    await getDeployedContract();
    await getAllCurrentProject();
    await getMyContributedProjects();

    isLoading = false;
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
    print("==================>>>>>>>>> ${10000}");
    // print("==============================>>>>>>>>> ");
    _contractOfFactory = DeployedContract(
        ContractAbi.fromJson(_abiOfFactory!, "Crowdfunding"),
        _contractAddressOfFactory);

    //TODO 1 :- initializing contract functions
    _createNewProject = _contractOfFactory.function("startProject");
    _countOfProjects = _contractOfFactory.function("numberOfProjects");
    _returnAllProjects = _contractOfFactory.function("returnAllProjects");
    _getMyprojects = _contractOfFactory.function("getMyprojects");
    print("==============================>>>>>>>>> 1");
    _getMyContributedProjects =
        _contractOfFactory.function("getMyContributedProjects");
    print("==================>>>>>>>>> ${0000}");
    var totalProjectCount = await _client!.call(
        contract: _contractOfFactory, function: _countOfProjects, params: []);
    print("==================>>>>>>>>> ${totalProjectCount}");
  }

  getAllCurrentProject() async {
    isLoading = true;
    var myProjectsAddress = await _client!.call(
        contract: _contractOfFactory, function: _returnAllProjects, params: []);

    myProjectsAddress =
        myProjectsAddress[0]; // coz it return a 2d array initially

    allProjects.clear();
    for (int i = 0; i < myProjectsAddress.length; i++) {
      var _tmpContract = DeployedContract(
          ContractAbi.fromJson(_abiOfProject!, "Project"),
          myProjectsAddress[i]);

      _getSummary = _tmpContract.function("getSummary");

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
      );

      allProjects.add(_tmpProject);

      print(PROJECT_STATE[_tmpProject.state]);
      isLoading = false;
      allProjects = new List.from(allProjects.reversed);
      notifyListeners();
      print(
          "=====================================================least day= ddd===========sd==================================================== ${allProjects.length}");
    }
  }

  double convertionWeiToEth(bool isAmountEth, double _amount) {
    const double one_eth_in_wei = 1000000000000000000;

    if (isAmountEth) {
      return _amount * one_eth_in_wei;
    }

    return _amount / one_eth_in_wei;
  }

  invest(
      {required projectContractAddress,
      required double amount,
      required privateKey}) async {
    List<dynamic> credDetails = await getCredentials(_privateKey);

    var _credentials = credDetails[0];
    var _ownAddress = credDetails[1];

    var _tmpContract = DeployedContract(
        ContractAbi.fromJson(_abiOfProject!, "Project"),
        projectContractAddress);

    _contibute = _tmpContract.function("contibute");

    amount = convertionWeiToEth(true, amount);

    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _tmpContract,
            function: _contibute,
            value: await EtherAmount.fromUnitAndValue(
                EtherUnit.wei, amount.toInt().toString()),
            from: EthereumAddress.fromHex(_ownAddress.toString()),
            parameters: []));
    await getAllCurrentProject();
    await getMyContributedProjects();
  }

  getWithdrawDetails({required projectAddress}) async {
    print(
        "WithDraw details WithDraw details WithDraw details WithDraw details WithDraw detailYYYYsWithDraw details");

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
    print(currentProjectWithdrawDetails);
  }

  String unixEpochToReadableText(int epoch) {
    var millis = epoch;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis * 1000);
    var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return d12.toString();
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
    print(
        "1111111111111111 11111111111111111111111111 contributorsList contributorsList contributorsList contributorsList contributorsList ${contributorsListOfProject}");
  }

  getMyContributedProjects() async {
    List<dynamic> credDetails = await getCredentials(_privateKey);
    var _credentials = credDetails[0];
    var _ownAddress = EthereumAddress.fromHex(ethAddress);
    var myProjectsAddress = await _client!.call(
        sender: _ownAddress,
        contract: _contractOfFactory,
        function: _getMyContributedProjects,
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

      print(
          "=====================================================least day========xvccxv========================================================");
      print(difference);
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
          landLocation: _projectSummary[11].toString());

      myProjects.add(_tmpProject);

      print(PROJECT_STATE[_tmpProject.state]);
      myProjects = List.from(myProjects.reversed);
      notifyListeners();
    }
  }
}
