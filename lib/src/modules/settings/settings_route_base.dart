import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/page/settings_page.dart';
import 'package:pokemon_app_evertec/src/modules/settings/settings_routes.dart';

class SettingsRouteBase {
  static List<GoRoute> get routes => [
    GoRoute(path: SettingsRoutes.settings.path,
      builder: (context, state) => const SettingsPage() ,
    )
  ];
}