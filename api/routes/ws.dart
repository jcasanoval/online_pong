import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:redis/redis.dart';

import '../models/game_state.dart';

Future<Response> onRequest(RequestContext context) async {
  final redisCon = RedisConnection();

  final gameId = context.request.uri.queryParameters['gameId'];
  if (gameId == null) {
    return Response(statusCode: 400, body: 'gameId is required');
  }

  final playerId = context.request.uri.queryParameters['playerId'];
  if (playerId == null) {
    return Response(statusCode: 400, body: 'playerId is required');
  }

  final command = await redisCon.connect('localhost', 6379);
  final gameJson = await command.get('game:$gameId');
  late GameState gameState;
  if (gameJson == null) {
    gameState = GameState(50, 50, 50, 50, [playerId]);
    await command.set('game:$gameId', gameState.toJson());
  } else {
    gameState = GameState.fromJson(gameJson as String);
    gameState.players.add(playerId);
    await command.set('game:$gameId', gameState.toJson());
  }

  if (gameState.players.length > 2) {
    return Response(statusCode: 400, body: 'Game is full');
  }

  final handler = webSocketHandler(
    (channel, protocol) {
      // A new client has connected to our server.
      print('connected');

      Timer.periodic(const Duration(seconds: 1), (_) async {
        final gameJson = await command.get('game:$gameId');
        channel.sink.add(gameJson);
      });

      // Listen for messages from the client.
      channel.stream.listen(
        (event) async {
          await command.multi().then((transaction) {
            /// Update game state transactionally
            // transaction.set(key, value);
            transaction.exec();
          });
        },
        // The client has disconnected.
        onDone: () => print('disconnected'),
      );
    },
  );

  return handler(context);
}
