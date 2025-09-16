import 'package:spotify/features/authentication/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity userEntity;
  AuthAuthenticated({required this.userEntity});
}
