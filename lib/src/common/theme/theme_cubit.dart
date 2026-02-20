import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokemon_app_evertec/src/common/theme/theme_state.dart';

const _themeModeKey = 'app_theme_mode';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(),
        super(const ThemeState());

  final FlutterSecureStorage _storage;

  static const List<ThemeMode> _cycle = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  Future<void> loadSavedTheme() async {
    final value = await _storage.read(key: _themeModeKey);
    final index = int.tryParse(value ?? '');
    if (index != null && index >= 0 && index < _cycle.length) {
      emit(state.copyWith(themeMode: _cycle[index]));
    }
  }

  Future<void> toggleTheme() async {
    final currentIndex = _cycle.indexOf(state.themeMode);
    final nextIndex = (currentIndex + 1) % _cycle.length;
    final next = _cycle[nextIndex];
    emit(state.copyWith(themeMode: next));
    await _storage.write(key: _themeModeKey, value: nextIndex.toString());
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state.themeMode == mode) return;
    emit(state.copyWith(themeMode: mode));
    final index = _cycle.indexOf(mode);
    if (index >= 0) {
      await _storage.write(key: _themeModeKey, value: index.toString());
    }
  }
}
