import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const SettingsState());

  final FirebaseAuth _auth;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> loadUserProfile() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(
          isLoading: false,
          userProfile: const UserProfile(name: '—', email: '—', phone: '—'),
        ));
        return;
      }
      final profile = UserProfile(
        name: user.displayName?.trim().isNotEmpty == true
            ? user.displayName!
            : 'Usuario',
        email: user.email ?? '—',
        phone: user.phoneNumber ?? '—',
      );
      emit(state.copyWith(userProfile: profile, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
