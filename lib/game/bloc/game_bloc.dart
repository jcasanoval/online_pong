import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_domain/game_domain.dart';

part 'game_event.dart';

class GameBloc extends Bloc<GameEvent, GameState?> {
  GameBloc(this.gameId, this.playerId)
      : super(
          GameState(50, 50, 50, 50, [
            Player(id: playerId, username: 'Player A'),
            const Player(id: '2', username: 'Player B'),
          ]),
        ) {
    on<DragUpdate>(dragUpdate);
  }

  final String gameId;
  final String playerId;

  void dragUpdate(DragUpdate event, Emitter<GameState?> emit) {
    final gameState = state;
    if (gameState == null) {
      return;
    }

    if (gameState.players[0].id == playerId) {
      emit(
        gameState.copyWith(
          playerAPosition: (gameState.playerAPosition + event.dX).clamp(0, 100),
        ),
      );
    } else {
      emit(
        gameState.copyWith(
          playerBPosition: (gameState.playerBPosition + event.dX).clamp(0, 100),
        ),
      );
    }
  }
}
