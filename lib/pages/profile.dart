import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/common/extensions/go_router_extensions.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/constants/app_urls.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_cubit.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_state.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_info.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_list_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_list_state.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_cubit.dart';
import 'package:spotify/features/song/presentation/widgets/favorite_button.dart';
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
            _favoriteSongs(),
          ],
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteSongListCubit()..getFavoriteSongs(),
        ),
        BlocProvider(create: (context) => FavoriteSongToggleCubit()),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'FAVORITE SONGS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            BlocConsumer<FavoriteSongListCubit, FavoriteSongListState>(
              listener: (context, state) {
                if (state is FavoriteSongListFailure) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      AppSnackBar(
                        context: context,
                        message: state.errorMessage,
                      ).showError(),
                    );
                }
              },
              builder: (context, state) {
                if (state is FavoriteSongListLoading) {
                  return Container(
                    margin: EdgeInsets.only(top: 120),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }
                if (state is FavoriteSongListLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.favoriteSongs.length,
                    itemBuilder: (context, index) {
                      return _favoriteSongItem(
                        context,
                        state.favoriteSongs[index],
                        index,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteSongItem(
    BuildContext context,
    SongEntity favoriteSong,
    int index,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    '${AppUrls.coverFirestorage}${favoriteSong.artist} - ${favoriteSong.title}.jpg?${AppUrls.mediaAlt}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteSong.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  favoriteSong.artist,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(favoriteSong.duration.toString().replaceAll('.', ':')),
            SizedBox(width: 30),
            FavoriteButton(
              songId: favoriteSong.id,
              isFavorite: favoriteSong.isFavorite,
              onPressed: () {
                context.read<FavoriteSongListCubit>().removeSongByIndex(index);
              },
            ),
          ],
        ),
      ],
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
          BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    var result = await sl<SignoutUsecase>().call();
                    result.fold(
                      (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBar(
                            context: context,
                            message: error,
                          ).showError(),
                        );
                      },
                      (user) {
                        context.read<AuthCubit>().signedOut();
                        GoRouter.of(
                          context,
                        ).popUntilPath(AppRoutes.chooseMode.path);
                        context.pushNamed(AppRoutes.signupOrSignin.name);
                      },
                    );
                  },
                );
              },
            ),
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
