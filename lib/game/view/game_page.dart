import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_pong/app/cubit/user_cubit.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/l10n/l10n.dart';
import 'package:online_pong/loading/cubit/cubit.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.gameId});

  static const routeName = '/game/:gameId';

  final String gameId;

  factory GamePage.pageBuilder(_, GoRouterState routerState) {
    final gameId = routerState.pathParameters['gameId']!;
    return GamePage(
      gameId: gameId,
      key: Key('game_page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
          },
        ),
        BlocProvider(
          create: (context) => GameBloc(
            gameId,
            context.read<UserCubit>().state.id,
          ),
        ),
      ],
      child: const Scaffold(
        body: SafeArea(child: GameView()),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontSize: 4,
        );

    final game = OnlinePong(
      l10n: context.l10n,
      effectPlayer: context.read<AudioCubit>().effectPlayer,
      textStyle: textStyle,
      images: context.read<PreloadCubit>().images,
      gameBloc: context.read(),
    );

    return GameWidget(game: game);
  }
}
