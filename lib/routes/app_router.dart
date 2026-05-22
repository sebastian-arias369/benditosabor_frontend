import 'package:go_router/go_router.dart';
import 'package:benditosabor/auth/views/login_view.dart';
import 'package:benditosabor/auth/views/register_view.dart';
import 'package:benditosabor/auth/views/home_view.dart';
import 'package:benditosabor/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isLoggingIn = state.matchedLocation == '/login';
    final isRegistering = state.matchedLocation == '/register';

    if (!isLoggedIn && !isLoggingIn && !isRegistering) {
      return '/login';
    }

    if (isLoggedIn && (isLoggingIn || isRegistering)) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/category/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId'];
        return Scaffold(
          appBar: AppBar(title: const Text('Categoría')),
          body: Center(
            child: Text('Categoría $categoryId (por implementar)'),
          ),
        );
      },
    ),
    GoRoute(
      path: '/item/:itemId',
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'];
        return Scaffold(
          appBar: AppBar(title: const Text('Producto')),
          body: Center(
            child: Text('Producto $itemId (por implementar)'),
          ),
        );
      },
    ),
  ],
);
