import 'dart:async';
import 'dart:math';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response(statusCode: 200, body: 'Hello, World!');
}

String _generateRandomCode() {
  final random = Random();
  final asciiA = 'A'.codeUnitAt(0);
  final asciiZ = 'Z'.codeUnitAt(0);
  final codeUnits = List.generate(4, (index) {
    return random.nextInt(asciiZ - asciiA + 1) + asciiA;
  });

  return String.fromCharCodes(codeUnits);
}
