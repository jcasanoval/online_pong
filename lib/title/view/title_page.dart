import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_pong/app/app.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/l10n/l10n.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  factory TitlePage.pageBuilder(_, __) {
    return const TitlePage(
      key: Key('title_page'),
    );
  }

  static const routeName = '/';

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
                context.pushNamed(
                  GamePage.routeName,
                  pathParameters: {
                    'gameId': _generateRandomCode(),
                  },
                );
              },
              child: const Center(child: Text('Create game')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            height: 64,
            child: ElevatedButton(
              onPressed: () => _joinGame(context),
              child: const Center(child: Text('Join game')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            height: 64,
            child: TextButton(
              onPressed: () => _changeUsername(context),
              child: const Center(child: Text('Change username')),
            ),
          ),
        ],
      ),
    );
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
                inputFormatters: [
                  CapsLockFormatter(),
                  FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
                ],
                maxLength: 4,
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
      await context.pushNamed(
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

class CapsLockFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
