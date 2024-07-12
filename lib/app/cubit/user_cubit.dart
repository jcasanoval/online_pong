import 'package:equatable/equatable.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:game_domain/game_domain.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<Player> {
  UserCubit() : super(const Player(id: '', username: 'Anonymous'));

  void init() {
    if (state.id.isEmpty) {
      final guid = Guid.generate();
      emit(Player(id: guid.value, username: state.username));
    }
  }

  void updateUsername(String username) {
    emit(Player(id: state.id, username: username));
  }

  @override
  Player? fromJson(Map<String, dynamic> json) => Player.fromMap(json);

  @override
  Map<String, dynamic>? toJson(Player state) => state.toMap();
}
