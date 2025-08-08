import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/core/constants/app_vectors.dart';
import 'package:spotify/route/route_config.dart';
import 'package:spotify/shared/extensions/is_dark_mode.dart';
import 'package:spotify/shared/widgets/appbar/app_bar.dart';
import 'package:spotify/shared/widgets/button/basic_button.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Color(0xff1C1B1B) : null,
      appBar: BasicAppbar(title: SvgPicture.asset(AppVectors.logo, height: 40)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleText(),
            SizedBox(height: 30),
            _emailTextField(context),
            SizedBox(height: 16),
            _passwordTextField(context),
            SizedBox(height: 30),
            BasicButton(onPressed: () {}, title: 'Sign In'),
            const Spacer(),
            _registerText(context),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member ?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            context.pushReplacementNamed(AppRoutes.signup.name);
          },
          child: Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff288CE9),
            ),
          ),
        ),
      ],
    );
  }
}
