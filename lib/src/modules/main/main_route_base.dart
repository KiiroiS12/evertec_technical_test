import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/modules/main/main_routes.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/page/pokemon_details_page.dart';

class MainRouteBase {
  static List<GoRoute> get routes => [
    GoRoute(
      path: MainRoutes.pokemonDetails.path,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;
        return PokemonDetailsPage(pokemonId: id);
      },
    ),
  ];
}