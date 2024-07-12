import 'dart:convert';

import 'package:game_domain/game_domain.dart';

class GameState {
  const GameState(
    this.playerAPosition,
    this.playerBPosition,
    this.ballX,
    this.ballY,
    this.players,
  );

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      map['playerAPosition'] as double? ?? 0.0,
      map['playerBPosition'] as double? ?? 0.0,
      map['ballX'] as double? ?? 0.0,
      map['ballY'] as double? ?? 0.0,
      (map['players'] as List<Map<String, dynamic>>)
          .map<Player>(Player.fromMap)
          .toList(),
    );
  }

  factory GameState.fromJson(String source) =>
      GameState.fromMap(json.decode(source) as Map<String, dynamic>);

  final double playerAPosition;

  final double playerBPosition;

  final double ballX;

  final double ballY;

  final List<Player> players;

  Map<String, dynamic> toMap() {
    return {
      'playerAPosition': playerAPosition,
      'playerBPosition': playerBPosition,
      'ballX': ballX,
      'ballY': ballY,
      'players': players,
    };
  }

  String toJson() => json.encode(toMap());

  GameState copyWith({
    double? playerAPosition,
    double? playerBPosition,
    double? ballX,
    double? ballY,
    List<Player>? players,
  }) {
    return GameState(
      playerAPosition ?? this.playerAPosition,
      playerBPosition ?? this.playerBPosition,
      ballX ?? this.ballX,
      ballY ?? this.ballY,
      players ?? this.players,
    );
  }
}
