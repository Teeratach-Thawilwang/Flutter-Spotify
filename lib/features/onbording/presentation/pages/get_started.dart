import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/core/constants/app_images.dart';
import 'package:spotify/core/constants/app_vectors.dart';
import 'package:spotify/route/route_config.dart';
import 'package:spotify/shared/widgets/button/basic_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBackground),
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.05)),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 70),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                const Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '''Lorem ipsum dolor sit amet, \nconsectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.''',
                  style: TextStyle(
                    color: Color(0xff797979),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                BasicButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.chooseMode.name);
                  },
                  title: 'Get Started',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
