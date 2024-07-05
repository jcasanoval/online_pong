part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState(
    this.id,
    this.username,
  );

  final String id;

  final String username;

  @override
  List<Object> get props => [id, username];
}
