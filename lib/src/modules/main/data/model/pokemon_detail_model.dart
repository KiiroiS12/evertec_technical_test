import 'package:equatable/equatable.dart';

class PokemonStatItem extends Equatable {
  const PokemonStatItem({required this.name, required this.value});

  final String name;
  final int value;

  @override
  List<Object?> get props => [name, value];
}

class PokemonDetailModel extends Equatable {
  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> types;
  final int baseExperience;
  final List<String> abilities;
  final List<PokemonStatItem> stats;

  String get idFormatted => '#${id.toString().padLeft(3, '0')}';
  String get nameFormatted => name.toUpperCase();
  String get heightFormatted => '${(height / 10).toStringAsFixed(1)} m';
  String get weightFormatted => '${(weight / 10).toStringAsFixed(1)} kg';

  /// Generación según Pokédex nacional (1-151 Gen1, 152-251 Gen2, ...).
  int get generation {
    if (id <= 151) return 1;
    if (id <= 251) return 2;
    if (id <= 386) return 3;
    if (id <= 493) return 4;
    if (id <= 649) return 5;
    if (id <= 721) return 6;
    if (id <= 809) return 7;
    if (id <= 905) return 8;
    return 9;
  }

  String get generationLabel => 'Gen $generation';

  static String _statName(String apiName) {
    switch (apiName) {
      case 'hp':
        return 'PS';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'At. Esp.';
      case 'special-defense':
        return 'Def. Esp.';
      case 'speed':
        return 'Velocidad';
      default:
        return apiName;
    }
  }

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String? ?? '';
    final height = json['height'] as int? ?? 0;
    final weight = json['weight'] as int? ?? 0;
    final baseExperience = json['base_experience'] as int? ?? 0;
    final types = (json['types'] as List<dynamic>?)
            ?.map((e) {
              final type = e['type'] as Map<String, dynamic>?;
              return type?['name'] as String? ?? '';
            })
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
    final abilities = (json['abilities'] as List<dynamic>?)
            ?.map((e) {
              final ability = e['ability'] as Map<String, dynamic>?;
              return ability?['name'] as String? ?? '';
            })
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
    final statsRaw = (json['stats'] as List<dynamic>?) ?? [];
    final stats = statsRaw
        .map((e) {
          final stat = e['stat'] as Map<String, dynamic>?;
          final baseStat = e['base_stat'] as int? ?? 0;
          final nameKey = stat?['name'] as String? ?? '';
          return PokemonStatItem(
            name: _statName(nameKey),
            value: baseStat,
          );
        })
        .toList();
    final sprites = json['sprites'] as Map<String, dynamic>?;
    String imageUrl = sprites?['front_default'] as String? ?? '';
    final other = sprites?['other'] as Map<String, dynamic>?;
    final official = other?['official-artwork'] as Map<String, dynamic>?;
    if (official != null && official['front_default'] != null) {
      imageUrl = official['front_default'] as String;
    }
    if (imageUrl.isEmpty && sprites?['front_default'] != null) {
      imageUrl = sprites!['front_default'] as String;
    }
    return PokemonDetailModel(
      id: id,
      name: name,
      height: height,
      weight: weight,
      imageUrl: imageUrl,
      types: types,
      baseExperience: baseExperience,
      abilities: abilities,
      stats: stats,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, height, weight, imageUrl, types, baseExperience, abilities, stats];
}
