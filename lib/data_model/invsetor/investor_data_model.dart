import 'package:hive_flutter/hive_flutter.dart';

part 'investor_data_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  int? key;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted = false;

  ItemModel(
      {required this.title,
      required this.description,
      this.key,
      this.isCompleted = false});
}
