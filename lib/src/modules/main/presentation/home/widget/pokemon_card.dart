import 'package:flutter/material.dart';
import 'package:pokemon_app_evertec/src/modules/main/data/model/pokemon_model.dart';
import 'package:pokemon_app_evertec/src/modules/main/presentation/home/widget/pokemon_type_chip.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onTap,
    this.useHero = true,
  });

  final PokemonModel pokemon;
  final VoidCallback? onTap;
  final bool useHero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final card = Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outline, width: 2),
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    pokemon.idFormatted,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 40,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      height: 1.0,
                    ),
                  ),
                  if (pokemon.imageUrl.isNotEmpty)
                    _buildImage(context),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  pokemon.idFormatted,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pokemon.nameFormatted,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              pokemon.generationLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: pokemon.types
                  .take(2)
                  .map((t) => PokemonTypeChip(typeName: t))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemon.heightFormatted,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  pokemon.weightFormatted,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      child: card,
    );
  }

  Widget _buildImage(BuildContext context) {
    final image = Image.network(
      pokemon.imageUrl,
      height: 96,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        Icons.image_not_supported,
        size: 48,
        color: Theme.of(context).colorScheme.outline,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
    if (!useHero) return image;
    return Hero(
      tag: 'pokemon_image_${pokemon.id}',
      child: image,
    );
  }
}
