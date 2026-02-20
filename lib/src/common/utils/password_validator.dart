/// Resultado de la validación de contraseña segura.
class PasswordValidationResult {
  const PasswordValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  final bool isValid;
  final String? errorMessage;

  static const String minLengthError = 'Mínimo 8 caracteres.';
  static const String numberError = 'Al menos un número.';
  static const String specialError = 'Al menos un carácter especial (!@#\$%^&*(),.?":{}|<>).';
  static const String uppercaseError = 'Al menos una letra en mayúscula.';
}

/// Valida contraseña segura: mínimo 8 caracteres, un número,
/// un carácter especial y una letra en mayúscula.
PasswordValidationResult validateSecurePassword(String password) {
  if (password.length < 8) {
    return const PasswordValidationResult(
      isValid: false,
      errorMessage: PasswordValidationResult.minLengthError,
    );
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return const PasswordValidationResult(
      isValid: false,
      errorMessage: PasswordValidationResult.numberError,
    );
  }
  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=\[\]\\;/`~]').hasMatch(password)) {
    return const PasswordValidationResult(
      isValid: false,
      errorMessage: PasswordValidationResult.specialError,
    );
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return const PasswordValidationResult(
      isValid: false,
      errorMessage: PasswordValidationResult.uppercaseError,
    );
  }
  return const PasswordValidationResult(isValid: true);
}
