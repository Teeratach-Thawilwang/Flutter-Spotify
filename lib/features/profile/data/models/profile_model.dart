import 'package:spotify/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  String? displayName;
  String? email;
  String? imageUrl;
  int? followingCount;
  int? followerCount;

  ProfileModel({
    required this.displayName,
    required this.email,
    required this.imageUrl,
    required this.followingCount,
    required this.followerCount,
  });

  ProfileModel.fromJson(Map<String, dynamic> data) {
    displayName = data['name'];
    email = data['email'];
    imageUrl = data['imageUrl'];
    followingCount = data['followingCount'] ?? 0;
    followerCount = data['followerCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': displayName,
      'email': email,
      'imageUrl': imageUrl,
      'followingCount': followingCount,
      'followerCount': followerCount,
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      displayName: displayName!,
      email: email!,
      imageUrl: imageUrl,
      followingCount: followingCount!,
      followerCount: followerCount!,
    );
  }
}
