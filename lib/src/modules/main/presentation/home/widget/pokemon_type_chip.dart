import 'package:flutter/material.dart';

class PokemonTypeChip extends StatelessWidget {
  const PokemonTypeChip({
    super.key,
    required this.typeName,
  });

  final String typeName;

  static const Map<String, Color> _typeColors = {
    'normal': Color(0xFFA8A878),
    'fire': Color(0xFFF08030),
    'water': Color(0xFF6890F0),
    'electric': Color(0xFFF8D030),
    'grass': Color(0xFF78C850),
    'ice': Color(0xFF98D8D8),
    'fighting': Color(0xFFC03028),
    'poison': Color(0xFFA040A0),
    'ground': Color(0xFFE0C068),
    'flying': Color(0xFFA890F0),
    'psychic': Color(0xFFF85888),
    'bug': Color(0xFFA8B820),
    'rock': Color(0xFFB8A038),
    'ghost': Color(0xFF705898),
    'dragon': Color(0xFF7038F8),
    'dark': Color(0xFF705848),
    'steel': Color(0xFFB8B8D0),
    'fairy': Color(0xFFEE99AC),
  };

  Color get _backgroundColor =>
      _typeColors[typeName.toLowerCase()] ?? const Color(0xFF9E9E9E);

  Color _textColor(BuildContext context) {
    final bg = _backgroundColor;
    final luminance = 0.299 * bg.r + 0.587 * bg.g + 0.114 * bg.b;
    final isDark = luminance > 0.5;
    return isDark ? Colors.black87 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black87;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Text(
        typeName.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: _textColor(context),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
