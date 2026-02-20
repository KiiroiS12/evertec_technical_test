import 'package:flutter/material.dart';
import 'package:pokemon_app_evertec/src/common/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      darkTheme: ThemeData.dark(),
      routerConfig: appRouter,
    );
  }
}
