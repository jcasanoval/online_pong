import 'package:game_domain/models/game_state.dart';
import 'package:server_connection/server_connection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketGameConnection extends GameConnection {
  WebSocketGameConnection(this.channel);

  final WebSocketChannel channel;

  @override
  void addEvent(String event) {
    channel.sink.add(event);
  }

  @override
  void disconnect() {
    channel.sink.close();
  }

  @override
  Stream<GameState> get eventStream => channel.stream.map(
        (event) => GameState.fromJson(event as String),
      );
}
