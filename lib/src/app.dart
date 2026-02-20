import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app_evertec/src/common/router/app_router.dart';
import 'package:pokemon_app_evertec/src/common/theme/app_theme.dart';
import 'package:pokemon_app_evertec/src/common/theme/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) =>
              GetIt.instance.get<ThemeCubit>()..loadSavedTheme(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Pokédex',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: context.watch<ThemeCubit>().state.themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
