import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app_evertec/src/common/theme/theme_cubit.dart';

class ThemeDiRegister {
  static void setup(GetIt getIt) {
    getIt.registerSingleton<FlutterSecureStorage>(
      const FlutterSecureStorage(),
    );
    getIt.registerSingleton<ThemeCubit>(
      ThemeCubit(storage: getIt.get<FlutterSecureStorage>()),
    );
  }
}
