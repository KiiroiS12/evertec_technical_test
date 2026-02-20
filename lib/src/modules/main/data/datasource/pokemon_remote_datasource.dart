import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_detail_model.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_model.dart';

class PokemonRemoteDatasource {
  PokemonRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  static const _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  final http.Client _client;

  Future<PokemonModel> getPokemonById(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load pokemon $id: ${response.statusCode}');
    }
    final map = jsonDecode(response.body) as Map<String, dynamic>;
    return PokemonModel.fromJson(map);
  }

  Future<PokemonDetailModel> getPokemonDetailById(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load pokemon $id: ${response.statusCode}');
    }
    final map = jsonDecode(response.body) as Map<String, dynamic>;
    return PokemonDetailModel.fromJson(map);
  }

  Future<List<PokemonModel>> getPokemonList(int fromId, int toId) async {
    final futures = <Future<PokemonModel>>[];
    for (int i = fromId; i <= toId; i++) {
      futures.add(getPokemonById(i));
    }
    return Future.wait(futures);
  }

  Future<List<PokemonModel>> getPokemonListByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final futures = ids.map((id) => getPokemonById(id)).toList();
    return Future.wait(futures);
  }
}
