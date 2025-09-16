import 'package:spotify/features/authentication/domain/entities/user_entity.dart';

class UserModel {
  String? userId;
  String? fullName;
  String? email;

  UserModel.fromJson(Map<String, dynamic> data) {
    userId = data['userId'];
    email = data['email'];
    fullName = data['fullName'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(userId: userId!, email: email!, fullName: fullName);
  }
}
