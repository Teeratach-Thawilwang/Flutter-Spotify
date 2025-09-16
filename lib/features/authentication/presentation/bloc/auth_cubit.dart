import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/presentation/bloc/auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthUnauthenticated());

  void signedIn(UserEntity user) {
    emit(AuthAuthenticated(userEntity: user));
  }

  void signedOut() {
    emit(AuthUnauthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    UserEntity userEntity = UserEntity.fromJson(json);
    return AuthAuthenticated(userEntity: userEntity);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAuthenticated) {
      return state.userEntity.toJson();
    }
    return null;
  }
}
