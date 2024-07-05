import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_pong/app/app.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/l10n/l10n.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static const routeName = '/title';

  factory TitlePage.pageBuilder(_, __) {
    return const TitlePage(
      key: Key('title_page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.titleAppBarTitle),
      ),
      body: const SafeArea(child: TitleView()),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Welcome back ${context.watch<UserCubit>().state.username}!'),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                context.pushReplacementNamed(
                  GamePage.routeName,
                  pathParameters: {
                    'gameId': '',
                  },
                );
              },
              child: Center(child: Text('Create game')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            height: 64,
            child: ElevatedButton(
              onPressed: () => _joinGame(context),
              child: Center(child: Text('Join game')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            height: 64,
            child: TextButton(
              onPressed: () => _changeUsername(context),
              child: Center(child: Text('Change username')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _joinGame(BuildContext context) async {
    final controller = TextEditingController();
    final gameId = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Join game'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Game ID',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Join'),
            ),
          ],
        );
      },
    );
    if (gameId != null) {
      context.pushReplacementNamed(
        GamePage.routeName,
        pathParameters: {
          'gameId': gameId,
        },
      );
    }
  }

  Future<void> _changeUsername(BuildContext context) async {
    final controller = TextEditingController();
    final username = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change username'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
    if (username != null) {
      context.read<UserCubit>().updateUsername(username);
    }
  }
}
