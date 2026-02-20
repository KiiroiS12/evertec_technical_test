import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/modules/auth/auth_route_base.dart';
import 'package:pokemon_app_evertec/src/modules/auth/auth_routes.dart';
import 'package:pokemon_app_evertec/src/modules/main/main_route_base.dart';
import 'package:pokemon_app_evertec/src/modules/main/main_routes.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/page/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AuthRoutes.login.path,
  routes: [
    ...AuthRouteBase.routes,
    GoRoute(
      path: MainRoutes.home.path,
      builder: (context, state) => const HomePage(),
    ),
    ...MainRouteBase.routes,
  ],
);
