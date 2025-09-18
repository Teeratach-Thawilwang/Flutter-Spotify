import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/features/song/domain/usecases/add_or_remove_favorite_song.dart';
import 'package:spotify/service_locator.dart';

class FavoriteButton extends StatefulWidget {
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
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isFavorite != widget.isFavorite) {
      setIsFavorite(widget.isFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await onPressHandle(context, () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        });
      },
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
        size: widget.size,
        color: const Color(0xff6C6C6C),
      ),
    );
  }

  void setIsFavorite(bool val) {
    setState(() {
      _isFavorite = val;
    });
  }

  Future<void> onPressHandle(
    BuildContext context,
    VoidCallback onSuccess,
  ) async {
    var result = await sl<AddOrRemoveFavoriteSongUsecase>().call(
      params: widget.songId,
    );
    result.fold(
      (error) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            AppSnackBar(
              context: context,
              message: error,
              onUndo: () async {
                var scaffoldMessenger = ScaffoldMessenger.of(context);
                onPressHandle(context, onSuccess);
                scaffoldMessenger.hideCurrentSnackBar();
              },
            ).showError(),
          );
      },
      (result) {
        setIsFavorite(result);
        onSuccess();
      },
    );
  }
}
