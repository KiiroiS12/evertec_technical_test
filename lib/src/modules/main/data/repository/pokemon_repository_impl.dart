import 'package:pokemon_app_evertec/src/modules/main/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_detail_model.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_model.dart';

class PokemonRepositoryImpl {
  PokemonRepositoryImpl({PokemonRemoteDatasource? datasource})
      : _datasource = datasource ?? PokemonRemoteDatasource();

  final PokemonRemoteDatasource _datasource;

  Future<List<PokemonModel>> getPokemonList(int fromId, int toId) {
    return _datasource.getPokemonList(fromId, toId);
  }

  Future<List<PokemonModel>> getPokemonListByIds(List<int> ids) {
    return _datasource.getPokemonListByIds(ids);
  }

  Future<PokemonDetailModel> getPokemonDetail(int id) {
    return _datasource.getPokemonDetailById(id);
  }
}
