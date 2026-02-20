import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app_evertec/src/common/constants/app_info.dart';
import 'package:pokemon_app_evertec/src/common/constants/app_strings.dart';
import 'package:pokemon_app_evertec/src/modules/auth/auth_routes.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/cubit/settings_cubit.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/cubit/settings_state.dart';

Future<void> showSettingsBottomSheet(BuildContext context) =>
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => SettingsPage(
        scrollController: scrollController,
      ),
    ),
  );

Future<void> _showSignOutConfirmDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.outline, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: colorScheme.surface,
        title: Text(
          AppStrings.confirmarCerrarSesionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
        ),
        content: Text(
          AppStrings.confirmarCerrarSesionMessage,
          style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppStrings.cancelar),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppStrings.confirmar),
          ),
        ],
      );
    },
  );
  if (context.mounted && confirmed == true) {
    await context.read<SettingsCubit>().signOut();
    if (context.mounted) {
      Navigator.of(context).pop();
      context.go(AuthRoutes.login.path);
    }
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..loadUserProfile(),
      child: _SettingsView(scrollController: scrollController),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView({this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _DragHandle(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            AppStrings.ajustes,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Flexible(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state.isLoading && state.userProfile == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.errorMessage != null && state.userProfile == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage!),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () =>
                            context.read<SettingsCubit>().loadUserProfile(),
                        child: const Text(AppStrings.reintentar),
                      ),
                    ],
                  ),
                );
              }
              final profile = state.userProfile;
              return ListTileTheme(
                data: ListTileTheme.of(context).copyWith(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    if (profile != null) ...[
                      const _SectionTitle(title: AppStrings.perfil),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text(AppStrings.nombre),
                        subtitle: Text(profile.name),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: const Text(AppStrings.correo),
                        subtitle: Text(profile.email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone_outlined),
                        title: const Text(AppStrings.celular),
                        subtitle: Text(profile.phone),
                      ),
                    ],
                    const Divider(height: 24),
                    const _SectionTitle(title: AppStrings.aplicacion),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text(AppStrings.version),
                      subtitle: Text(AppInfo.versionDisplay),
                    ),
                    const Divider(height: 24),
                    const _SectionTitle(title: AppStrings.sesion),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(AppStrings.cerrarSesion),
                      subtitle: const Text(AppStrings.cerrarSesionSubtitle),
                      onTap: () => _showSignOutConfirmDialog(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
