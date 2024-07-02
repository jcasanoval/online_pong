// Copyright (c) 2024, Very Good Ventures
// https://verygood.ventures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_pong/game/game.dart';
import 'package:online_pong/loading/loading.dart';
import 'package:online_pong/title/title.dart';

class AppRouter {
  AppRouter({
    required GlobalKey<NavigatorState> navigatorKey,
    String? initialLocation = LoadingPage.routeName,
    List<NavigatorObserver> navigatorObservers = const [],
  }) {
    _goRouter = _routes(
      initialLocation,
      navigatorObservers,
      navigatorKey,
    );
  }

  late final GoRouter _goRouter;

  GoRouter get routes => _goRouter;

  GoRouter _routes(
    String? initialLocation,
    List<NavigatorObserver> navigatorObservers,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    return GoRouter(
      initialLocation: initialLocation,
      observers: navigatorObservers,
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          name: LoadingPage.routeName,
          path: LoadingPage.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            name: LoadingPage.routeName,
            child: LoadingPage.pageBuilder(context, state),
          ),
        ),
        GoRoute(
          name: TitlePage.routeName,
          path: TitlePage.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            name: TitlePage.routeName,
            child: TitlePage.pageBuilder(context, state),
          ),
        ),
        GoRoute(
          name: GamePage.routeName,
          path: GamePage.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            name: GamePage.routeName,
            child: GamePage.pageBuilder(context, state),
          ),
        ),
      ],
    );
  }
}
