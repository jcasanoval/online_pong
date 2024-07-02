import 'package:game_domain/models/game_state.dart';

abstract class GameConnection {
  void disconnect();

  void addEvent(String event);

  Stream<GameState> get eventStream;
}
