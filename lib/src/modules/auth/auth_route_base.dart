import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/modules/auth/auth_routes.dart';
import 'package:pokemon_app_evertec/src/modules/auth/presentation/login/page/login_page.dart';
import 'package:pokemon_app_evertec/src/modules/auth/presentation/signup/page/signup_page.dart';

class AuthRouteBase {
  static List<GoRoute> get routes => [
    GoRoute(path: AuthRoutes.login.path,
      builder: (context, state) => const LoginPage() ,
    ),
    GoRoute(path: AuthRoutes.signup.path,
      builder: (context, state) => const SignupPage() ,
    )
  ];
}