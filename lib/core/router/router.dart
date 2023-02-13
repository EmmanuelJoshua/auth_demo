import 'package:cakewallet_task/views/pin_auth_screen.dart';
import 'package:cakewallet_task/views/setup_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cakewallet_task/views/menu_screen.dart';

part 'routes.dart';

final router = GoRouter(
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('${state.error}'),
    ),
  ),
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (context, state) => const MenuScreen(),
      routes: [
        GoRoute(
          path: Routes.setupPin.removeSlash(),
          builder: (context, state) => const SetupPinScreen(),
        ),
        GoRoute(
          path: Routes.pinAuth.removeSlash(),
          builder: (context, state) => const PinAuthScreen(),
        ),
      ],
    )
  ],
);
