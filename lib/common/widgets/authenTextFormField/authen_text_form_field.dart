import 'package:flutter/material.dart';

class AuthenTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const AuthenTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
