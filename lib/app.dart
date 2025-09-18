import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/theme/app_theme.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_cubit.dart';
import 'package:spotify/route/app_router.dart';
import 'package:spotify/common/bloc/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp.router(
          routerConfig: appRouter,
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
