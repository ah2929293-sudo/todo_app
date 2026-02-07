import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String image;
  @HiveField(1)
  String name;

  UserModel({required this.name, required this.image});
}
