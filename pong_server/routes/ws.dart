import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:redis/redis.dart';

Future<Response> onRequest(RequestContext context) async {
  final redisCon = RedisConnection();
  final command = await redisCon.connect('localhost', 6379);
  final handler = webSocketHandler(
    (channel, protocol) {
      // A new client has connected to our server.
      print('connected');

      Timer.periodic(const Duration(seconds: 1), (_) {
        /// TODO: send game state
      });

      // Listen for messages from the client.
      channel.stream.listen(
        (event) {
          command.multi().then((transaction) {
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
  // final current = int.parse((await command.get('count') as String?) ?? '0');
  // command.set('count', '${current + 1}');
  // return Response(body: current.toString());
}
