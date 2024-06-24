// ignore_for_file: cascade_invocations

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/l10n/l10n.dart';

class _MockAppLocalizations extends Mock implements AppLocalizations {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

class _OnlinePong extends OnlinePong {
  _OnlinePong({
    required super.l10n,
    required super.effectPlayer,
    required super.textStyle,
    required super.images,
  });

  @override
  Future<void> onLoad() async {}
}

void main() {
  group('$CounterComponent', () {
    late AppLocalizations l10n;

    setUp(() {
      l10n = _MockAppLocalizations();

      when(() => l10n.counterText(any())).thenAnswer(
        (invocation) => 'counterText: ${invocation.positionalArguments[0]}',
      );
    });

    OnlinePong createFlameGame() {
      return _OnlinePong(
        l10n: l10n,
        effectPlayer: _MockAudioPlayer(),
        textStyle: const TextStyle(),
        images: Images(),
      );
    }

    testWithGame(
      'has all components',
      createFlameGame,
      (game) async {
        final component = CounterComponent(position: Vector2.all(1));
        await game.ensureAdd(component);

        expect(component.text, isNotNull);
      },
    );

    testWithGame(
      'changes text count correctly',
      createFlameGame,
      (game) async {
        final component = CounterComponent(position: Vector2.all(1));
        await game.ensureAdd(component);

        expect(component.text.text, equals(''));
        game.counter = 1;
        game.update(0.1);
        expect(component.text.text, equals('counterText: 1'));

        game.counter = 2;
        game.update(0.1);
        expect(component.text.text, equals('counterText: 2'));
      },
    );
  });
}
