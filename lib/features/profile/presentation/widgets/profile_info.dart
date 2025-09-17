import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/core/constants/app_images.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';
import 'package:spotify/features/profile/presentation/bloc/profile_info_cubit.dart';
import 'package:spotify/features/profile/presentation/bloc/profile_info_state.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getProfile(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is ProfileInfoLoaded) {
              return _infoCard(context, state.profileEntity);
            }

            if (state is ProfileInfoFailure) {
              return Text(state.errorMessage);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context, ProfileEntity profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: profile.imageUrl == null
                  ? AssetImage(AppImages.spotifyLogo)
                  : NetworkImage(profile.imageUrl!),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          profile.email,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: context.isDarkMode ? Color(0xffD8D4D4) : Color(0xff222222),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          profile.displayName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Color(0xff222222),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _followInfo(context, 'Following', profile.followingCount),
            _followInfo(context, 'Follower', profile.followerCount),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _followInfo(BuildContext context, String title, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Color(0xff222222),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: context.isDarkMode ? Color(0xffA1A1A1) : Color(0xff585858),
          ),
        ),
      ],
    );
  }
}
