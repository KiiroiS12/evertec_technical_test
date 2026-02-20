import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/constants/pokemon_constants.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_model.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/repository/pokemon_repository_impl.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({PokemonRepositoryImpl? repository})
      : _repository = repository ?? PokemonRepositoryImpl(),
        super(const HomeState());

  final PokemonRepositoryImpl _repository;

  Future<void> loadPokemonList() async {
    emit(state.copyWith(status: HomeStatus.loading, errorMessage: null));
    try {
      final List<List<PokemonModel>> results = await Future.wait([
        _repository.getPokemonListByIds(PokemonConstants.starterPokemonIds),
        _repository.getPokemonList(
            PokemonConstants.gridFromId, PokemonConstants.gridToId),
      ]);
      final carouselList = results[0];
      final gridList = results[1];
      emit(state.copyWith(
        status: HomeStatus.success,
        carouselList: carouselList,
        pokemonList: gridList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
