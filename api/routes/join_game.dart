import 'dart:async';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response(statusCode: 200, body: 'Hello, World!');
}
