import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/cubit/settings_cubit.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/cubit/settings_state.dart';

Future<void> showSettingsBottomSheet(BuildContext context) =>
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => SettingsPage(
      scrollController: null,
    ),
  );

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
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
        Flexible(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
