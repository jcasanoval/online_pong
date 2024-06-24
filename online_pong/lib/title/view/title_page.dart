import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: SizedBox(
        width: 250,
        height: 64,
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacementNamed(GamePage.routeName);
          },
          child: Center(child: Text(l10n.titleButtonStart)),
        ),
      ),
    );
  }
}
