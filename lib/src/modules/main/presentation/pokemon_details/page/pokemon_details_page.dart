import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/common/constants/app_strings.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_detail_model.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/repository/pokemon_repository_impl.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/widget/pokemon_type_chip.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/pokemon_details/cubit/pokemon_details_state.dart';

const String _pokemonCryBaseUrl =
    'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest';

class _PokemonCryButton extends StatefulWidget {
  const _PokemonCryButton({required this.pokemonId});

  final int pokemonId;

  @override
  State<_PokemonCryButton> createState() => _PokemonCryButtonState();
}

class _PokemonCryButtonState extends State<_PokemonCryButton> {
  AudioPlayer? _player;
  StreamSubscription<void>? _subscription;

  void _disposePlayer() {
    _subscription?.cancel();
    _subscription = null;
    _player?.dispose();
    _player = null;
  }

  Future<void> _playCry() async {
    _disposePlayer();
    final player = AudioPlayer();
    _player = player;
    _subscription = player.onPlayerComplete.listen((_) {
      _disposePlayer();
    });
    final url = '$_pokemonCryBaseUrl/${widget.pokemonId}.ogg';
    await player.play(UrlSource(url)).catchError((_) {
      _disposePlayer();
    });
  }

  @override
  void dispose() {
    _disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _playCry,
      icon: const Icon(Icons.volume_up),
      tooltip: 'Reproducir grito',
    );
  }
}

class _PokemonDetailImage extends StatelessWidget {
  const _PokemonDetailImage({
    required this.pokemonId,
    required this.imageUrl,
  });

  final int pokemonId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'pokemon_image_$pokemonId',
      child: Image.network(
        imageUrl,
        height: 180,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.image_not_supported,
          size: 80,
          color: theme.colorScheme.outline,
        ),
      ),
    );
  }
}

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    super.key,
    required this.pokemonId,
    this.repository,
  });

  final int pokemonId;
  final PokemonRepositoryImpl? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailsCubit(
        pokemonId: pokemonId,
        repository:
            repository ?? GetIt.instance.get<PokemonRepositoryImpl>(),
      )..loadDetails(),
      child: _PokemonDetailsView(pokemonId: pokemonId),
    );
  }
}

class _PokemonDetailsView extends StatelessWidget {
  const _PokemonDetailsView({required this.pokemonId});

  final int pokemonId;

  static const String _heroTagPrefix = 'pokemon_image_';

  String get _heroTag => '$_heroTagPrefix$pokemonId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(AppStrings.detalle),
      ),
      body: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case PokemonDetailsStatus.initial:
            case PokemonDetailsStatus.loading:
              return Center(
                child: Hero(
                  tag: _heroTag,
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                      height: 180,
                      width: 180,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            case PokemonDetailsStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage ?? AppStrings.errorAlCargar,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () =>
                            context.read<PokemonDetailsCubit>().loadDetails(),
                        child: const Text(AppStrings.reintentar),
                      ),
                    ],
                  ),
                ),
              );
            case PokemonDetailsStatus.success:
              final pokemon = state.pokemon!;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: _DetailContent(pokemon: pokemon),
              );
          }
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.pokemon});

  final PokemonDetailModel pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Center(
          child: Text(
            pokemon.idFormatted,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            '${AppStrings.generacion}: ${pokemon.generationLabel}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
        if (pokemon.imageUrl.isNotEmpty)
          Center(
            child: _PokemonDetailImage(
              pokemonId: pokemon.id,
              imageUrl: pokemon.imageUrl,
            ),
          ),
        const SizedBox(height: 8),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pokemon.nameFormatted,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              _PokemonCryButton(pokemonId: pokemon.id),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: pokemon.types
              .map((t) => PokemonTypeChip(typeName: t))
              .toList(),
        ),
        const SizedBox(height: 24),
        _SectionTitle(title: AppStrings.medidas),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _InfoChip(
              label: AppStrings.altura,
              value: pokemon.heightFormatted,
              icon: Icons.height,
            ),
            _InfoChip(
              label: AppStrings.peso,
              value: pokemon.weightFormatted,
              icon: Icons.monitor_weight_outlined,
            ),
            _InfoChip(
              label: AppStrings.expBase,
              value: '${pokemon.baseExperience}',
              icon: Icons.star_outline,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionTitle(title: AppStrings.habilidades),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: pokemon.abilities
              .map((a) => Chip(
                    label: Text(a.replaceAll('-', ' ')),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        _SectionTitle(title: AppStrings.estadisticasBase),
        ...pokemon.stats.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    s.name,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: (s.value / 255).clamp(0.0, 1.0),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 32,
                  child: Text(
                    '${s.value}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
