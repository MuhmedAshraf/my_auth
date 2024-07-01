import 'package:my_auth/core/api/end_points.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? profilePic;
  final Map<String, dynamic> address;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
     this.profilePic,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['user'][ApiKeys.name],
      email: jsonData['user'][ApiKeys.email],
      phone: jsonData['user'][ApiKeys.phone],
      profilePic: jsonData['user'][ApiKeys.profilePic],
      address: jsonData['user'][ApiKeys.location],
    );
  }
}
