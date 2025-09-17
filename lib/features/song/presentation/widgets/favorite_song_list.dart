import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/core/constants/app_urls.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_list_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_list_state.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_cubit.dart';
import 'package:spotify/features/song/presentation/widgets/favorite_button.dart';
import 'package:spotify/route/route_config.dart';

class FavoriteSongList extends StatelessWidget {
  const FavoriteSongList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteSongListCubit()..getFavoriteSongs(),
        ),
        BlocProvider(create: (context) => FavoriteSongToggleCubit()),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
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
                        const SizedBox(height: 16),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.pushNamed(AppRoutes.songPlayer.name, extra: favoriteSong);
      },
      child: Row(
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
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
                  context.read<FavoriteSongListCubit>().removeSongByIndex(
                    index,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
