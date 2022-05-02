import 'package:web3dart/web3dart.dart';

class Project {
  var contractAddress;
  String creator;
  String creatorName;
  String phoneNumber;
  String raiseBy;
  String projectName;
  String projectDescription;
  String goalAmount;
  String currentBalance;
  String minimunContribution;
  int state;
  int numberOfContributors;

  Project(
      {required this.contractAddress,
      required this.creator,
      required this.creatorName,
      required this.phoneNumber,
      required this.raiseBy,
      required this.projectName,
      required this.projectDescription,
      required this.goalAmount,
      required this.currentBalance,
      required this.minimunContribution,
      required this.state,
      required this.numberOfContributors});
}

class NewProjectModel {
  String projectName;
  String phoneNumber;
  String landLocation;
  String projectDescription;
  String goalAmount;
  String minimumContribution;
  String duration;
  String privateKey;

  NewProjectModel({
    required this.projectName,
    required this.phoneNumber,
    required this.landLocation,
    required this.projectDescription,
    required this.goalAmount,
    required this.minimumContribution,
    required this.duration,
    required this.privateKey,
  });
}
