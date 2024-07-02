// ignore_for_file: prefer_const_constructors
import 'package:server_connection/server_connection.dart';
import 'package:test/test.dart';

void main() {
  group('ServerConnection', () {
    test('can be instantiated', () {
      expect(ServerConnection(), isNotNull);
    });
  });
}
