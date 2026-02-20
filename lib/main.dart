import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app_evertec/firebase_options.dart';
import 'package:pokemon_app_evertec/src/app.dart';
import 'package:pokemon_app_evertec/src/common/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final getIt = GetIt.instance;
  setup(getIt);

  FlutterNativeSplash.remove();

  runApp(const App());
}
