import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:game_domain/models/game_state.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/l10n/l10n.dart';

class OnlinePong extends FlameGame {
  OnlinePong({
    required this.l10n,
    required this.effectPlayer,
    required this.gameBloc,
    required this.textStyle,
    required Images images,
  }) {
    this.images = images;
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  final GameBloc gameBloc;

  int counter = 0;

  double get width => size.x;
  double get height => size.y;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);

  @override
  Future<void> onLoad() async {
    final world = World(
      children: [
        PlayArea(),
        PlayerBat(
          gameBloc.playerId,
          cornerRadius: const Radius.circular(8),
          position: size / 2,
          size: Vector2(8, 1),
        ),
        // Unicorn(position: size / 2),
        // CounterComponent(
        //   position: (size / 2)
        //     ..sub(
        //       Vector2(0, 16),
        //     ),
        // ),
      ],
    );

    final camera = CameraComponent(world: world);
    await add(
      FlameBlocProvider<GameBloc, GameState?>.value(
        value: gameBloc,
        children: [world, camera],
      ),
    );

    camera.viewfinder.position = size / 2;
    camera.viewfinder.zoom = 8;
  }
}
