import 'package:hive_flutter/hive_flutter.dart';

part 'investor_data_model.g.dart';

@HiveType(typeId: 0)
class LoggedInfo {
  @HiveField(0)
  int? key;

  @HiveField(1)
  String userName;

  @HiveField(2)
  String ethAddress;

  LoggedInfo({
    required this.userName,
    required this.ethAddress,
    this.key,
  });
}
