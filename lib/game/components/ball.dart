import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:online_pong/game/game.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameRef<OnlinePong> {
  Ball({
    required this.velocity,
    required super.position,
    required super.radius,
    required this.difficultyModifier,
  }) : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff1e6091)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.y >= game.height) {
        // add(
        //   RemoveEffect(
        //     delay: 0.35,
        //     onComplete: () => game.playState = PlayState.gameOver,
        //   ),
        // );
      }
      if (intersectionPoints.first.x <= 0 ||
          intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      }
    } else if (other is PlayerBat) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else {
      debugPrint('Ball collided with $other');
    }
  }
}
