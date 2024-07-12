import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:online_pong/game/game.dart';

class PlayerBat extends PositionComponent
    with HasGameRef<OnlinePong>, FlameBlocListenable<GameBloc, GameState?> {
  PlayerBat(
    this.playerId, {
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  final Radius cornerRadius;

  final String playerId;

  final _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        cornerRadius,
      ),
      _paint,
    );
  }

  @override
  void onNewState(GameState? state) {
    if (state == null) {
      return;
    }
    late double targetX;
    if (state.players[0].id == playerId) {
      targetX = state.playerAPosition;
    } else {
      targetX = state.playerBPosition;
    }
    add(
      MoveToEffect(
        Vector2(
          game.width * (targetX / 100),
          position.y,
        ),
        EffectController(duration: 0.1),
      ),
    );
  }
}
