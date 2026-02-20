# Pokémon App – Evertec

Aplicación Flutter de tipo Pokédex desarrollada como prueba técnica para Evertec. Permite explorar Pokémon, ver detalles y gestionar sesión con Firebase Auth.

---

## Características

- **Autenticación**: Inicio de sesión y registro con Firebase Auth (email/contraseña).
- **Inicio**: Carrusel con Pokémon principales (starters de cada generación) y listado del 1 al 200.
- **Detalle**: Pantalla de detalle por Pokémon con imagen, generación, tipos, medidas, habilidades y estadísticas base.
- **Grito del Pokémon**: Reproducción del grito al tocar el icono de audio junto al nombre en la pantalla de detalle.
- **Transición Hero**: Animación de la imagen entre la card del listado y la pantalla de detalle.
- **Ajustes**: Bottom sheet con perfil (nombre, correo, celular), versión de la app, selector de tema (Claro / Oscuro / Auto) y cierre de sesión. Tema persistido con Flutter Secure Storage.
- **Tema**: Estilo Pokédex (pixel art, tipografía Press Start 2P, colores rojo/negro/amarillo).

---

## Tecnologías

| Área            | Tecnología              |
|-----------------|-------------------------|
| Framework       | Flutter (SDK ^3.11)     |
| Estado          | flutter_bloc (Cubit)    |
| Navegación      | go_router               |
| Inyección de dependencias | get_it          |
| Auth            | firebase_auth           |
| Persistencia    | flutter_secure_storage (tema) |
| Red             | http + PokeAPI         |
| UI              | Material, google_fonts  |
| Audio           | audioplayers            |
| Tests           | flutter_test, mocktail  |

---

## Requisitos previos

- [Flutter](https://docs.flutter.dev/get-started/install) (SDK ^3.11.0)
- Cuenta Firebase y proyecto con Auth (email/contraseña) habilitado
- Archivo `lib/firebase_options.dart` generado con FlutterFire CLI (ver más abajo)

---

## Instalación y ejecución

### 1. Clonar e instalar dependencias

```bash
cd pokemon_app_evertec
flutter pub get
```

### 2. Configurar Firebase

Si aún no tienes `firebase_options.dart`:

```bash
flutterfire configure
```

Configura en Firebase Console:

- **Authentication** → Sign-in method → Email/Password activado.

### 3. Ejecutar la app

```bash
flutter run
```

Por defecto la app arranca en la ruta de login. Tras iniciar sesión o registrarte se navega al home.

---

## Estructura del proyecto

```
lib/
├── main.dart                 # Punto de entrada, Firebase init
├── firebase_options.dart     # Configuración Firebase (generado)
└── src/
    ├── app.dart              # MaterialApp.router, ThemeCubit, tema
    ├── common/
    │   ├── constants/        # AppStrings, AppInfo
    │   ├── di/               # dependency_injection, ThemeDiRegister, MainDiRegister
    │   ├── router/           # app_router (go_router)
    │   ├── theme/            # AppTheme, ThemeCubit, ThemeState
    │   ├── utilities/         # AppColors
    │   ├── utils/            # password_validator
    │   └── widgets/          # main_shell (no usado en rutas actuales)
    └── modules/
        ├── auth/
        │   └── presentation/
        │       ├── login/    # LoginPage, LoginCubit, LoginState
        │       ├── signup/   # SignupPage, SignupCubit, SignupState
        │       └── auth_route_base, auth_routes
        ├── main/
        │   ├── data/
        │   │   ├── constants/   # PokemonConstants (starters, rangos)
        │   │   ├── datasource/  # PokemonRemoteDatasource (PokeAPI)
        │   │   ├── model/       # PokemonModel, PokemonDetailModel
        │   │   └── repository/  # PokemonRepositoryImpl
        │   ├── main_route_base, main_routes
        │   └── presentation/
        │       ├── home/        # HomePage, HomeCubit, PokemonCard, etc.
        │       └── pokemon_details/  # PokemonDetailsPage, PokemonDetailsCubit
        └── settings/
            └── presentation/
                ├── page/     # SettingsPage (bottom sheet)
                ├── cubit/    # SettingsCubit, SettingsState
                └── settings_routes
```

---

## Arquitectura

- **Estado**: Cubits por pantalla o flujo (LoginCubit, SignupCubit, HomeCubit, PokemonDetailsCubit, SettingsCubit, ThemeCubit). Sin capa domain; la presentación usa repositorios e implementaciones concretas.
- **Navegación**: go_router con rutas planas: login, signup, `/home`, `/pokemon-details/:id`. Ajustes se abren como bottom sheet desde un FAB en home.
- **Datos Pokémon**: PokeAPI (https://pokeapi.co). Carrusel: IDs fijos de starters (`PokemonConstants.starterPokemonIds`). Listado: IDs 1–200.
- **Constantes**: Títulos y textos en `AppStrings`; IDs y rangos en `PokemonConstants`; tema en `ThemeCubit` con Flutter Secure Storage.

### Inyección de dependencias (GetIt)

La app usa **get_it** para registrar y resolver dependencias. En `main.dart` se llama a `setup(GetIt.instance)` antes de `runApp`, donde se registran:

- **ThemeDiRegister**: `FlutterSecureStorage`, `ThemeCubit`.
- **MainDiRegister**: `PokemonRemoteDatasource`, `PokemonRepositoryImpl`.

En producción, `App` obtiene `ThemeCubit` desde GetIt; `HomePage` y `PokemonDetailsPage` usan `GetIt.instance.get<PokemonRepositoryImpl>()` cuando no se les pasa un repositorio. En los tests se inyecta un mock por parámetro (`repository: mockRepository`), por lo que no se usa GetIt en los tests.

---

## Tests

```bash
flutter test
```

Los tests incluyen, entre otros:

- `test/src/modules/main/presentation/home/page/home_page_test.dart`
- `test/src/modules/main/presentation/pokemon_details/page/pokemon_details_page_test.dart`

Se usan mocks (mocktail) del repositorio para no depender de red ni Firebase en tests.

---

## Rutas principales

| Ruta                 | Descripción                    |
|----------------------|--------------------------------|
| `/` (login)          | Inicio de sesión               |
| `/signup`            | Registro                       |
| `/home`              | Inicio: carrusel + grid        |
| `/pokemon-details/:id` | Detalle del Pokémon con id `:id` |

Ajustes: FAB en `/home` → `showSettingsBottomSheet(context)`.

---

## Versión

1.0.0 (build 1) — definida en `lib/src/common/constants/app_info.dart`.

---

## Replicar la app desde cero

Si quieres construir esta aplicación paso a paso desde cero (orden de commits, primeras tareas en código, decisiones de arquitectura y tips), usa la guía **[BUILD_FROM_SCRATCH.md](BUILD_FROM_SCRATCH.md)**.

---

## Recursos

- [Flutter](https://docs.flutter.dev/)
- [PokeAPI](https://pokeapi.co/)
- [Flutter Bloc](https://bloclibrary.dev/)
- [go_router](https://pub.dev/packages/go_router)
