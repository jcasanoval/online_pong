import 'package:online_pong/app/app.dart';
import 'package:online_pong/bootstrap.dart';

void main() {
  bootstrap(
    (serverConnection) async => App(
      serverConnection: serverConnection,
    ),
  );
}
