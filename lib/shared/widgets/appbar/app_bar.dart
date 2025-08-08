import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/shared/extensions/is_dark_mode.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double paddingLeft;
  final double iconButtonSize;

  const BasicAppbar({
    this.title,
    this.paddingLeft = 20,
    this.iconButtonSize = 40,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title ?? const Text(''),
      centerTitle: true,
      leadingWidth: (2 * paddingLeft) + iconButtonSize,
      leading: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          maxWidth: iconButtonSize,
          maxHeight: iconButtonSize,
        ),
        onPressed: () {
          context.pop();
        },
        icon: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? Colors.white.withAlpha(20)
                : Colors.black.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
