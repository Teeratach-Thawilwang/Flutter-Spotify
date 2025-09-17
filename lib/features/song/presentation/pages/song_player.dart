import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/constants/app_urls.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/song_player_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/song_player_state.dart';
import 'package:spotify/features/song/presentation/widgets/favorite_button.dart';

class SongPlayer extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayer({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Color(0xff1C1B1B) : null,
      appBar: BasicAppbar(
        title: Text(
          'Now Playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_rounded),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SongPlayerCubit()
              ..loadSong(
                '${AppUrls.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppUrls.mediaAlt}',
              ),
          ),
          BlocProvider(create: (context) => FavoriteSongToggleCubit()),
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(context),
              const SizedBox(height: 35),
              _songPlayer(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrls.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppUrls.mediaAlt}',
          ),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: context.isDarkMode
                    ? Color(0xffBABABA)
                    : Color(0xff404040),
              ),
            ),
          ],
        ),
        FavoriteButton(
          songId: songEntity.id,
          isFavorite: songEntity.isFavorite,
          size: 30,
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator(color: AppColors.primary);
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 9),
                thumbColor: context.isDarkMode
                    ? Color(0xffB7B7B7)
                    : Color(0xff5C5C5C),
                inactiveColor: context.isDarkMode
                    ? Color(0xff343440)
                    : Color(0xffafafaf),
                activeColor: context.isDarkMode
                    ? Color(0xffB7B7B7)
                    : Color(0xff5C5C5C),
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode
                          ? Color(0xff878787)
                          : Color(0xff404040),
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode
                          ? Color(0xff878787)
                          : Color(0xff404040),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 40,
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }
}
