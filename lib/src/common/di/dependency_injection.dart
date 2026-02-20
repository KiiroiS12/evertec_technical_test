import 'package:get_it/get_it.dart';
import 'package:pokemon_app_evertec/src/common/di/main_di_register.dart';
import 'package:pokemon_app_evertec/src/common/di/theme_di_register.dart';

/// Configura todas las dependencias del proyecto en [getIt].
/// Se invoca desde [main] antes de [runApp].
void setup(GetIt getIt) {
  ThemeDiRegister.setup(getIt);
  MainDiRegister.setup(getIt);
}
