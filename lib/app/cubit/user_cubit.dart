import 'package:equatable/equatable.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(const UserState('', 'Anonymous'));

  void init() {
    if (state.id.isEmpty) {
      final guid = Guid.generate();
      emit(UserState(guid.value, state.username));
    }
  }

  void updateUsername(String username) {
    emit(UserState(state.id, username));
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState(
      json['id'] as String,
      json['username'] as String,
    );
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'id': state.id,
      'username': state.username,
    };
  }
}
