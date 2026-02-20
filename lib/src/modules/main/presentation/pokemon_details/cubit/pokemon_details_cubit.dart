import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/repository/pokemon_repository_impl.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/cubit/pokemon_details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  PokemonDetailsCubit({
    required int pokemonId,
    PokemonRepositoryImpl? repository,
  })  : _pokemonId = pokemonId,
        _repository = repository ?? PokemonRepositoryImpl(),
        super(const PokemonDetailsState());

  final int _pokemonId;
  final PokemonRepositoryImpl _repository;

  Future<void> loadDetails() async {
    emit(state.copyWith(status: PokemonDetailsStatus.loading, errorMessage: null));
    try {
      final pokemon = await _repository.getPokemonDetail(_pokemonId);
      emit(state.copyWith(status: PokemonDetailsStatus.success, pokemon: pokemon));
    } catch (e) {
      emit(state.copyWith(
        status: PokemonDetailsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
