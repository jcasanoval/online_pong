import 'dart:convert';

class GameState {
  const GameState(
    this.playerAPosition,
    this.playerBPosition,
    this.ballX,
    this.ballY,
  );

  final double playerAPosition;

  final double playerBPosition;

  final double ballX;

  final double ballY;

  Map<String, dynamic> toMap() {
    return {
      'playerAPosition': playerAPosition,
      'playerBPosition': playerBPosition,
      'ballX': ballX,
      'ballY': ballY,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      map['playerAPosition'] as double? ?? 0.0,
      map['playerBPosition'] as double? ?? 0.0,
      map['ballX'] as double? ?? 0.0,
      map['ballY'] as double? ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameState.fromJson(String source) =>
      GameState.fromMap(json.decode(source) as Map<String, dynamic>);
}
