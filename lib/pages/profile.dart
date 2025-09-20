import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/common/extensions/go_router_extensions.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_cubit.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_state.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_info.dart';
import 'package:spotify/features/song/domain/usecases/clear_songs.dart';
import 'package:spotify/features/song/presentation/widgets/favorite_song_list.dart';
import 'package:spotify/route/route_config.dart';
import 'package:spotify/service_locator.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Color(0xff1C1B1B) : null,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BasicAppbar(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              hideBack: true,
              backgroundColor: context.isDarkMode
                  ? Color(0xff2c2b2b)
                  : Colors.white,
              action: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: context.isDarkMode
                        ? AppColors.darkGrey
                        : Colors.white,
                    barrierColor: Colors.black.withValues(alpha: 0.15),
                    builder: (BuildContext context) {
                      return _singoutBottomSheet(context);
                    },
                  );
                },
                icon: Icon(Icons.more_vert_rounded),
              ),
            ),
            ProfileInfo(),
            const SizedBox(height: 30),
            FavoriteSongList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _singoutBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Sign out',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final router = GoRouter.of(context);
                  var result = await sl<SignoutUsecase>().call();
                  var isSignoutSuccess = false;

                  result.fold(
                    (error) {
                      messenger.showSnackBar(
                        AppSnackBar(
                          context: context,
                          message: error,
                        ).showError(),
                      );
                    },
                    (user) {
                      context.read<AuthCubit>().signedOut();
                      isSignoutSuccess = true;
                    },
                  );

                  if (isSignoutSuccess) {
                    await sl<ClearSongsUsecase>().call();
                    router.popUntilPath(AppRoutes.chooseMode.path);
                    router.pushNamed(AppRoutes.signupOrSignin.name);
                  }
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('ยกเลิก'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
