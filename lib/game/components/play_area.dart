import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:online_pong/game/game.dart';

class PlayArea extends RectangleComponent
    with HasGameRef<OnlinePong>, DragCallbacks {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final sizeOffset = 100 / game.width;
    final dX = event.localDelta.x * sizeOffset;
    game.gameBloc.add(DragUpdate(dX));
  }
}
