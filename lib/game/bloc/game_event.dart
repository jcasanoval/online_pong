part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class DragUpdate extends GameEvent {
  const DragUpdate(this.dX);

  final double dX;
}
