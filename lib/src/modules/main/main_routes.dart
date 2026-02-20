enum MainRoutes {
  home('/home'),
  pokemonDetails('/pokemon-details/:id');

  final String path;

  const MainRoutes(this.path);
}