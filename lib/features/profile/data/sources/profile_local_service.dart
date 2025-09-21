import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify/features/profile/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalService {
  Future<ProfileModel?> getProfile();
  Future<void> setProfile(ProfileModel profile);
  Future<void> clearProfile();
}

class ProfileLocalServiceImpl extends ProfileLocalService {
  final SharedPreferences prefs;
  static const String cacheKey = "CACHED_PROFILE";
  static const String cacheTimeKey = "CACHED_PROFILE_TIME";

  ProfileLocalServiceImpl({required this.prefs});

  @override
  Future<ProfileModel?> getProfile() async {
    final jsonString = prefs.getString(cacheKey);
    final cacheTime = prefs.getInt(cacheTimeKey);
    final int timeoutSeconds = dotenv.getInt(
      'PROFILE_CACHE_TIMEOUT_SECONDS',
      fallback: 300,
    );

    if (jsonString != null && cacheTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final cacheDuration = Duration(seconds: timeoutSeconds).inMilliseconds;

      if (currentTime - cacheTime < cacheDuration) {
        final Map<String, dynamic> decoded = json.decode(jsonString);
        return ProfileModel.fromJson(decoded);
      } else {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> setProfile(ProfileModel profile) async {
    profile.toJson();
    final jsonString = json.encode(profile.toJson());

    await prefs.setString(cacheKey, jsonString);
    await prefs.setInt(cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> clearProfile() async {
    await prefs.remove(cacheKey);
    await prefs.remove(cacheTimeKey);
  }
}
