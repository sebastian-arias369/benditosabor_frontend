import 'package:go_router/go_router.dart';
import 'package:benditosabor/auth/views/login_view.dart';
import 'package:benditosabor/auth/views/register_view.dart';
import 'package:benditosabor/auth/views/home_view.dart';
import 'package:benditosabor/auth/services/auth_service.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isLoggingIn = state.matchedLocation == '/login';
    final isRegistering = state.matchedLocation == '/register';

    // Si no está autenticado y no está en login/register, redirige a login
    if (!isLoggedIn && !isLoggingIn && !isRegistering) {
      return '/login';
    }

    // Si está autenticado y está en login/register, redirige a home
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
  ],
);
