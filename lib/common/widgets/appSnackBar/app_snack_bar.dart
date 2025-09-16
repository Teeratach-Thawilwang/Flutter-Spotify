import 'package:flutter/material.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/core/theme/app_colors.dart';

class AppSnackBar {
  final BuildContext context;
  final String message;
  final Function? onUndo;
  final Duration duration;

  AppSnackBar({
    required this.context,
    required this.message,
    required this.onUndo,
    this.duration = const Duration(seconds: 2),
  });

  SnackBar showSuccess() {
    return _snackBar(
      icon: Icons.check_circle,
      iconColor: AppColors.primary,
      textColor: context.isDarkMode ? Colors.white : Colors.black,
    );
  }

  SnackBar showError() {
    return _snackBar(
      icon: Icons.error,
      iconColor: Colors.red,
      textColor: context.isDarkMode ? Colors.red.shade400 : Colors.red,
    );
  }

  SnackBar _snackBar({
    required IconData icon,
    required Color iconColor,
    required Color textColor,
  }) {
    return SnackBar(
      duration: duration,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkGrey : Color(0xffE6E6E6),
          border: Border.all(
            color: context.isDarkMode
                ? Color.fromARGB(255, 86, 86, 86)
                : Color.fromARGB(255, 193, 193, 193),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 25),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onUndo != null)
              Row(
                children: [
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      onUndo!();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      "Undo",
                      style: TextStyle(color: Colors.blue[500], fontSize: 16),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
