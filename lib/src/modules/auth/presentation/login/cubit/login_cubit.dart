import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_evertec/src/modules/auth/presentation/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const LoginState());

  final FirebaseAuth _auth;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Ingresa correo y contraseña',
      ));
      return;
    }
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on FirebaseAuthException catch (e) {
      final message = _authErrorMessage(e.code);
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  String _authErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con este correo.';
      case 'wrong-password':
        return 'Contraseña incorrecta.';
      case 'invalid-email':
        return 'Correo electrónico no válido.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      default:
        return 'Error al iniciar sesión. Intenta de nuevo.';
    }
  }
}
