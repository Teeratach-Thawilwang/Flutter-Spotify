class ProfileEntity {
  final String displayName;
  final String email;
  final String? imageUrl;
  final int followingCount;
  final int followerCount;

  ProfileEntity({
    required this.displayName,
    required this.email,
    required this.imageUrl,
    required this.followingCount,
    required this.followerCount,
  });
}
