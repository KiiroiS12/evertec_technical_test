import 'package:get_it/get_it.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/repository/pokemon_repository_impl.dart';

/// Registro de dependencias del módulo main (datasource, repositorio).
class MainDiRegister {
  static void setup(GetIt getIt) {
    getIt.registerSingleton<PokemonRemoteDatasource>(PokemonRemoteDatasource());
    getIt.registerSingleton<PokemonRepositoryImpl>(PokemonRepositoryImpl(
      datasource: getIt.get<PokemonRemoteDatasource>(),
    ));
  }
}
