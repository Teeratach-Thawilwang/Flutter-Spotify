class UserEntity {
  String? userId;
  String? fullName;
  String? email;

  UserEntity({this.userId, this.fullName, this.email});

  UserEntity.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email, 'fullName': fullName};
  }
}
