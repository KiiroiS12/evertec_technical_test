import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
  });

  final int id;
  final String name;
  final int height; // decimetres
  final int weight; // hectograms
  final String imageUrl;
  final List<String> types;

  String get idFormatted => '#${id.toString().padLeft(3, '0')}';
  String get nameFormatted => name.toUpperCase();
  String get heightFormatted => '${(height / 10).toStringAsFixed(1)}M';
  String get weightFormatted => '${(weight / 10).toStringAsFixed(0)}KG';

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

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String? ?? '';
    final height = json['height'] as int? ?? 0;
    final weight = json['weight'] as int? ?? 0;
    final types = (json['types'] as List<dynamic>?)
            ?.map((e) {
              final type = e['type'] as Map<String, dynamic>?;
              return type?['name'] as String? ?? '';
            })
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];
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
    return PokemonModel(
      id: id,
      name: name,
      height: height,
      weight: weight,
      imageUrl: imageUrl,
      types: types,
    );
  }

  @override
  List<Object?> get props => [id, name, height, weight, imageUrl, types];
}
