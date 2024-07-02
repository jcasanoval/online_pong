import 'dart:convert';

class GameState {
  GameState(
    this.playerAPosition,
    this.playerBPosition,
    this.ballX,
    this.ballY,
    this.players,
  );

  double playerAPosition;

  double playerBPosition;

  double ballX;

  double ballY;

  List<String> players;

  Map<String, dynamic> toMap() {
    return {
      'playerAPosition': playerAPosition,
      'playerBPosition': playerBPosition,
      'ballX': ballX,
      'ballY': ballY,
      'players': players,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      map['playerAPosition'] as double? ?? 0.0,
      map['playerBPosition'] as double? ?? 0.0,
      map['ballX'] as double? ?? 0.0,
      map['ballY'] as double? ?? 0.0,
      map['players'] as List<String>? ?? <String>[],
    );
  }

  String toJson() => json.encode(toMap());

  factory GameState.fromJson(String source) =>
      GameState.fromMap(json.decode(source) as Map<String, dynamic>);
}
