import 'dart:async';

import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  final FutureOr Function()? onPressed;
  final String title;
  final double height;

  const BasicButton({
    required this.onPressed,
    required this.title,
    this.height = 90,
    super.key,
  });

  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressHandle,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(widget.height),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
          ],
          Text(widget.title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Future<void> onPressHandle() async {
    if (widget.onPressed == null || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
