import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_state.dart';

class FavoriteButton extends StatelessWidget {
  final String songId;
  final bool isFavorite;
  final double? size;

  const FavoriteButton({
    this.size,
    required this.songId,
    required this.isFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongCubit(),
      child: BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
        builder: (context, state) {
          if (state is FavoriteSongInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteSongCubit>().onToggleFavorite(songId);
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                size: size,
                color: const Color(0xff6C6C6C),
              ),
            );
          }

          if (state is FavoriteSongUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteSongCubit>().onToggleFavorite(songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: size,
                color: const Color(0xff6C6C6C),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
