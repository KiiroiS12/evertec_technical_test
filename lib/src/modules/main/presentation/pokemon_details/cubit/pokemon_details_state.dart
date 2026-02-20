import 'package:equatable/equatable.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_detail_model.dart';

enum PokemonDetailsStatus { initial, loading, success, failure }

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    this.status = PokemonDetailsStatus.initial,
    this.pokemon,
    this.errorMessage,
  });

  final PokemonDetailsStatus status;
  final PokemonDetailModel? pokemon;
  final String? errorMessage;

  PokemonDetailsState copyWith({
    PokemonDetailsStatus? status,
    PokemonDetailModel? pokemon,
    String? errorMessage,
  }) {
    return PokemonDetailsState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pokemon, errorMessage];
}
