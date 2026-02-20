import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/common/utils/password_validator.dart';
import 'package:pokemon_app_evertec/src/modules/auth/presentation/signup/cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const SignupState());

  final FirebaseAuth _auth;

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: SignupStatus.failure,
        errorMessage: 'Completa todos los campos.',
      ));
      return;
    }

    final passwordResult = validateSecurePassword(password);
    if (!passwordResult.isValid) {
      emit(state.copyWith(
        status: SignupStatus.failure,
        errorMessage: passwordResult.errorMessage,
      ));
      return;
    }

    emit(state.copyWith(status: SignupStatus.loading, errorMessage: null));

    try {
      await _auth.createUserWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      if (displayName != null && displayName.trim().isNotEmpty) {
        final user = _auth.currentUser;
        if (user != null) {
          await user.updateDisplayName(displayName.trim());
        }
      }

      emit(state.copyWith(status: SignupStatus.success));
    } on FirebaseAuthException catch (e) {
      final message = _authErrorMessage(e.code);
      emit(state.copyWith(
        status: SignupStatus.failure,
        errorMessage: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SignupStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  String _authErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Ya existe una cuenta con este correo.';
      case 'invalid-email':
        return 'Correo electrónico no válido.';
      case 'weak-password':
        return 'La contraseña no cumple los requisitos de seguridad.';
      case 'operation-not-allowed':
        return 'Registro con correo deshabilitado. Contacta al administrador.';
      default:
        return 'Error al crear la cuenta. Intenta de nuevo.';
    }
  }
}
