import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_state.dart';

/* 
  Need to wrap this widget with BlocProvider or MultiBlocProvider
  Example: BlocProvider(create: (context) => FavoriteSongToggleCubit()),
*/
class FavoriteButton extends StatelessWidget {
  final String songId;
  final bool isFavorite;
  final double? size;
  final Function? onPressed;

  const FavoriteButton({
    this.size,
    required this.songId,
    required this.isFavorite,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var localIsfavorite = isFavorite;
    return BlocConsumer<FavoriteSongToggleCubit, FavoriteSongToggleState>(
      listener: (context, state) {
        if (state is FavoriteSongToggleUpdated) {
          localIsfavorite = !localIsfavorite;
        }
        if (state is FavoriteSongToggleFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              AppSnackBar(
                context: context,
                message: state.errorMessage,
                onUndo: () async {
                  var scaffoldMessenger = ScaffoldMessenger.of(context);
                  await context
                      .read<FavoriteSongToggleCubit>()
                      .onToggleFavorite(songId);
                  scaffoldMessenger.hideCurrentSnackBar();
                },
              ).showError(),
            );
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            await context.read<FavoriteSongToggleCubit>().onToggleFavorite(
              songId,
            );
            if (onPressed != null) {
              onPressed!();
            }
          },
          icon: Icon(
            localIsfavorite ? Icons.favorite : Icons.favorite_outline_outlined,
            size: size,
            color: const Color(0xff6C6C6C),
          ),
        );
      },
    );
  }
}
