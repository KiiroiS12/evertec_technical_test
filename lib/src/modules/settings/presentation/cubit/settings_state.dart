import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  List<Object?> get props => [name, email, phone];
}

class SettingsState extends Equatable {
  const SettingsState({
    this.userProfile,
    this.isLoading = false,
    this.errorMessage,
  });

  final UserProfile? userProfile;
  final bool isLoading;
  final String? errorMessage;

  SettingsState copyWith({
    UserProfile? userProfile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SettingsState(
      userProfile: userProfile ?? this.userProfile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [userProfile, isLoading, errorMessage];
}
