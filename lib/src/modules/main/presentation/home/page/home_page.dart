import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/common/constants/app_strings.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/constants/pokemon_constants.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/repository/pokemon_repository_impl.dart';
import 'package:pokemon_app_evertec/src/modules/main/main_routes.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/cubit/home_cubit.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/cubit/home_state.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/widget/pokemon_card.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/page/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.repository,
  });

  final PokemonRepositoryImpl? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
            repository: repository ?? GetIt.instance.get<PokemonRepositoryImpl>(),
          )..loadPokemonList(),
      child: const _HomeView(),
    );
  }
}

int _responsiveCrossAxisCount(double width) {
  if (width >= 1600) return 6;
  if (width >= 1200) return 5;
  if (width >= 900) return 4;
  if (width >= 600) return 3;
  return 2;
}

double _responsiveChildAspectRatio(double width, int crossAxisCount) {
  if (crossAxisCount <= 2) return 0.78;
  if (crossAxisCount <= 3) return 0.85;
  return 0.92;
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final PageController _carouselPageController;

  static const double _carouselCardWidth = 150;
  static const double _carouselCardHeight = 240;
  static const double _carouselScaleCenter = 1.08;
  static const double _carouselScaleEdge = 0.88;

  @override
  void initState() {
    super.initState();
    _carouselPageController = PageController(viewportFraction: 0.42);
  }

  @override
  void dispose() {
    _carouselPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pokemon),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSettingsBottomSheet(context),
        child: const Icon(Icons.settings),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.failure:
              return Center(
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
                          context.read<HomeCubit>().loadPokemonList(),
                      child: const Text(AppStrings.reintentar),
                    ),
                  ],
                ),
              );
            case HomeStatus.success:
              final carouselList = state.carouselList;
              final gridList = state.pokemonList;
              if (carouselList.isEmpty && gridList.isEmpty) {
                return Center(child: Text(AppStrings.noHayPokemon));
              }
              final width = MediaQuery.of(context).size.width;
              final crossAxisCount = _responsiveCrossAxisCount(width);
              final aspectRatio =
                  _responsiveChildAspectRatio(width, crossAxisCount);

              return CustomScrollView(
                slivers: [
                  if (carouselList.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          AppStrings.pokemonPrincipales,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: _carouselCardHeight + 24,
                        child: PageView.builder(
                          controller: _carouselPageController,
                          itemCount: carouselList.length,
                          padEnds: true,
                          itemBuilder: (context, index) {
                            final pokemon = carouselList[index];
                            return AnimatedBuilder(
                              animation: _carouselPageController,
                              builder: (context, child) {
                                final page = _carouselPageController.hasClients
                                    ? (_carouselPageController.page ?? index.toDouble())
                                    : index.toDouble();
                                final delta = (index - page).abs();
                                final scale = (delta > 1.0)
                                    ? _carouselScaleEdge
                                    : (_carouselScaleCenter - (_carouselScaleCenter - _carouselScaleEdge) * delta).clamp(_carouselScaleEdge, _carouselScaleCenter);
                                return Center(
                                  child: Transform.scale(
                                    scale: scale,
                                    child: child,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  width: _carouselCardWidth,
                                  height: _carouselCardHeight,
                                  child: PokemonCard(
                                    pokemon: pokemon,
                                    onTap: () => context.push(
                                      MainRoutes.pokemonDetails.path
                                          .replaceFirst(':id', '${pokemon.id}'),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, carouselList.isEmpty ? 16 : 24, 16, 8),
                      child: Text(
                        AppStrings.todosLosPokemon,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  if (gridList.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(AppStrings.noHayMasPokemon),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                      sliver: SliverGrid(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: aspectRatio,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final pokemon = gridList[index];
                            final isStarter = PokemonConstants.starterPokemonIds
                                .contains(pokemon.id);
                            return PokemonCard(
                              pokemon: pokemon,
                              onTap: () => context.push(
                                MainRoutes.pokemonDetails.path
                                    .replaceFirst(':id', '${pokemon.id}'),
                              ),
                              useHero: !isStarter,
                            );
                          },
                          childCount: gridList.length,
                        ),
                      ),
                    ),
                ],
              );
          }
        },
      ),
    );
  }
}
