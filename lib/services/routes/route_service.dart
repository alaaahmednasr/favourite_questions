import 'package:favourite_questions/views/all_questions/presentation/screens/all_questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/enums/route_enum.dart';
import '../../views/favourites/presentation/screens/favourites_screen.dart';
import '../../views/on_boarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static final GoRouter router = GoRouter(
    observers: [routeObserver],
    initialLocation: '/onBoarding',
    routes: <RouteBase>[
      GoRoute(
        path: '/onBoarding',
        name: AppRoute.onBoarding.name,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/allQuestions',
        name: AppRoute.allQuestions.name,
        builder: (BuildContext context, GoRouterState state) {
          return const AllQuestionsScreen();
        },
      ),
      GoRoute(
        path: '/favourites',
        name: AppRoute.favourites.name,
        builder: (BuildContext context, GoRouterState state) {
          return const FavouritesScreen();
        },
      ),
    ],
  );
}
