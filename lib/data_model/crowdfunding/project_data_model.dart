class Project {
  var contractAddress;
  String creator;
  String creatorName;
  String phoneNumber;
  String raiseBy;
  String expiredAtInDays;
  String projectName;
  String projectDescription;
  String goalAmount;
  String currentBalance;
  String minimunContribution;
  int state;
  int numberOfContributors;
  String landLocation;
  bool projectClosing;

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
      required this.numberOfContributors,
      required this.expiredAtInDays,
      required this.landLocation,
      required this.projectClosing});
}

class ContributedProject {
  var contractAddress;
  String creator;
  String creatorName;
  String phoneNumber;
  String raiseBy;
  String expiredAtInDays;
  String projectName;
  String projectDescription;
  String goalAmount;
  String currentBalance;
  String minimunContribution;
  int state;
  int numberOfContributors;
  String landLocation;
  bool projectClosing;
  String myContribution;

  ContributedProject({
    required this.contractAddress,
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
    required this.numberOfContributors,
    required this.expiredAtInDays,
    required this.landLocation,
    required this.projectClosing,
    required this.myContribution,
  });
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
