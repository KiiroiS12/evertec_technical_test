import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/cubit/pokemon_details_state.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    super.key,
    required this.pokemonId,
  });

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailsCubit(pokemonId: pokemonId),
      child: _PokemonDetailsView(pokemonId: pokemonId),
    );
  }
}

class _PokemonDetailsView extends StatelessWidget {
  const _PokemonDetailsView({required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
        builder: (context, state) => const SizedBox.shrink(),
      ),
    );
  }
}
