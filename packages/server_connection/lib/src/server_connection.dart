import 'package:server_connection/server_connection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// {@template server_connection}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ServerConnection {
  /// {@macro server_connection}
  const ServerConnection(this.baseUrl);

  final String baseUrl;

  GameConnection connectToGame() {
    final channel = WebSocketChannel.connect(Uri(
      path: 'ws://$baseUrl/ws',
    ));
    return WebSocketGameConnection(channel);
  }
}
