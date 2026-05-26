import 'package:go_router/go_router.dart';
import 'package:benditosabor/auth/views/login_view.dart';
import 'package:benditosabor/auth/views/register_view.dart';
import 'package:benditosabor/auth/views/home_view.dart';
import 'package:benditosabor/auth/services/auth_service.dart';
import 'package:benditosabor/views/category/product_category_detail_view.dart';
import 'package:benditosabor/views/category/category_items_list_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isLoggingIn = state.matchedLocation == '/login';
    final isRegistering = state.matchedLocation == '/register';

    // Si tiene token, verifica que sea válido
    if (isLoggedIn) {
      final isValid = await AuthService.verifyToken();
      if (!isValid) {
        // Token inválido, logout
        await AuthService.logout();
        if (!isLoggingIn && !isRegistering) {
          return '/login';
        }
        return null;
      }
    }

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
      path: '/menu',
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/category/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId'];
        return CategoryItemsListView(categoryId: categoryId!);
      },
    ),
    GoRoute(
      path: '/item/:itemId',
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'];
        return ProductCategoryDetailView(itemId: itemId!);
      },
    ),
  ],
);
