class UserModel {
  String userId;
  String userName;
  String email;
  String ethAddress;

  UserModel(
      {required this.userId,
      required this.email,
      required this.ethAddress,
      required this.userName});

  // receving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map["uid"],
      email: map["email"],
      ethAddress: map["ethAddress"],
      userName: map["userName"],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      "uid": userId,
      "email": email,
      "userName": userName,
      "ethAddress": ethAddress
    };
  }
}
