import 'dart:convert';

import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({required this.id, required this.username});

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as String,
      username: map['username'] as String,
    );
  }

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;

  final String username;

  @override
  List<Object> get props => [id, username];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
    };
  }

  String toJson() => json.encode(toMap());
}
