import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/common/extensions/go_router_extensions.dart';
import 'package:spotify/common/widgets/appSnackBar/app_snack_bar.dart';
import 'package:spotify/core/constants/app_vectors.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_cubit.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_state.dart';
import 'package:spotify/route/route_config.dart';
import 'package:spotify/service_locator.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_button.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: BasicAppbar(
          title: SvgPicture.asset(AppVectors.logo, height: 40),
        ),
        backgroundColor: context.isDarkMode ? Color(0xff1C1B1B) : null,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(child: _content(context)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleText(),
              SizedBox(height: 30),
              _emailTextField(context),
              SizedBox(height: 16),
              _passwordTextField(context),
              SizedBox(height: 30),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return BasicButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      var result = await sl<SigninUsecase>().call(
                        params: SigninUsecaseParams(
                          email: _email.text.toString(),
                          password: _password.text.toString(),
                        ),
                      );
                      result.fold(
                        (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            AppSnackBar(
                              context: context,
                              message: error,
                            ).showError(),
                          );
                        },
                        (user) {
                          if (user != null) {
                            context.read<AuthCubit>().signedIn(user);
                          }
                          GoRouter.of(
                            context,
                          ).popUntilPath(AppRoutes.chooseMode.path);
                          context.pushNamed(AppRoutes.home.name);
                        },
                      );
                    },
                    title: 'Sign In',
                  );
                },
              ),
            ],
          ),
          Spacer(),
          _registerText(context),
        ],
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
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
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
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xff288CE9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
