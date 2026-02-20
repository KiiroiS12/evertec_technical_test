import 'package:equatable/equatable.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.carouselList = const [],
    this.pokemonList = const [],
    this.errorMessage,
  });

  final HomeStatus status;
  final List<PokemonModel> carouselList;
  final List<PokemonModel> pokemonList;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<PokemonModel>? carouselList,
    List<PokemonModel>? pokemonList,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      carouselList: carouselList ?? this.carouselList,
      pokemonList: pokemonList ?? this.pokemonList,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, carouselList, pokemonList, errorMessage];
}
