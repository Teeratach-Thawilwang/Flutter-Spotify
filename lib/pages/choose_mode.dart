import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/core/constants/app_images.dart';
import 'package:spotify/core/constants/app_vectors.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_cubit.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_state.dart';
import 'package:spotify/route/route_config.dart';
import 'package:spotify/common/bloc/theme_cubit.dart';
import 'package:spotify/common/widgets/button/basic_button.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(AppImages.chooseModeBackground),
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.15)),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(child: _content(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isLandscape = (size.width / size.height) > 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(AppVectors.logo),
          ),
          Expanded(child: SizedBox(height: 30)),
          const Text(
            'Choose Mode',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chooseModeButton('Dark Mode', AppVectors.moon, () {
                context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
              }),
              const SizedBox(width: 70),
              _chooseModeButton('Light Mode', AppVectors.sun, () {
                context.read<ThemeCubit>().updateTheme(ThemeMode.light);
              }),
            ],
          ),
          SizedBox(height: isLandscape ? 30 : 70),
          BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return BasicButton(
                  onPressed: () {
                    if (state is AuthAuthenticated) {
                      context.pushNamed(AppRoutes.home.name);
                    } else if (state is AuthUnauthenticated) {
                      context.pushNamed(AppRoutes.signupOrSignin.name);
                    }
                  },
                  title: 'Continue',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _chooseModeButton(
    String title,
    String appVectorIcon,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            splashColor: Colors.white.withValues(alpha: 0.4),
            highlightColor: Colors.white.withValues(alpha: 0.3),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(48, 57, 60, 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(appVectorIcon, fit: BoxFit.none),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
