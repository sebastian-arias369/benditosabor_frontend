import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// CustomDrawer — Estilo Barbershop · Claro con Volumen
/// Consistente con LoginViewTheme: warm gray, cards elevadas, sombras suaves
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  // ── Colores ────────────────────────────────────────────────────────────────────
  static const Color primaryBackground = Color(0xFFECE9E3);
  static const Color surfaceColor = Color(0xFFF8F6F1);
  static const Color primaryColor = Color(0xFF1A1A1A);
  static const Color mutedColor = Color(0xFF666666);
  static const Color subtleColor = Color(0xFF999999);
  static const Color borderColor = Color(0xFFD4D0C8);
  static const Color buttonTextLight = Color(0xFFF0EDE7);

  // ── Dimensiones ───────────────────────────────────────────────────────────────
  static const double headerTopPadding = 60.0;
  static const double headerBottomPadding = 32.0;
  static const double headerHorizontalPadding = 24.0;
  static const double menuItemRadius = 14.0;
  static const double menuItemPadding = 14.0;
  static const double iconSize = 22.0;
  static const double logoContainerSize = 48.0;
  static const double logoIconSize = 28.0;

  // ── Sombras ────────────────────────────────────────────────────────────────────
  static List<BoxShadow> get headerShadow => [
        const BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 32,
          offset: Offset(0, 8),
        ),
        const BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
        const BoxShadow(
          color: Color(0xB3FFFFFF),
          blurRadius: 0,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get activeItemShadow => [
        const BoxShadow(
          color: Color(0x10000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
        const BoxShadow(
          color: Color(0x99FFFFFF),
          blurRadius: 0,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get logoShadow => [
        const BoxShadow(
          color: Color(0x40000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];


  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: primaryBackground,
      child: Column(
        children: [
          // Header personalizado con estilo elegante
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: headerTopPadding,
              bottom: headerBottomPadding,
              left: headerHorizontalPadding,
              right: headerHorizontalPadding,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: headerShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Icono
                Container(
                  width: logoContainerSize,
                  height: logoContainerSize,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: buttonTextLight,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: logoShadow,
                  ),
                  child: const Icon(
                    Icons.content_cut_rounded,
                    size: logoIconSize,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                // Título
                const Text(
                  'ShearSync',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: buttonTextLight,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtítulo
                Text(
                  'MENÚ PRINCIPAL',
                  style: TextStyle(
                    fontFamily: null,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: subtleColor,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
          ),

          // Items del menú
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              children: [
                _buildMenuItem(
                  context: context,
                  icon: Icons.home_rounded,
                  title: 'Inicio',
                  route: '/publicaciones',
                  isActive: currentRoute == '/publicaciones',
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.photo_library_rounded,
                  title: 'Publicaciones',
                  route: '/publicaciones',
                  isActive: currentRoute == '/publicaciones',
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.event_seat_rounded,
                  title: 'Reservas',
                  route: '/reservas',
                  isActive: currentRoute == '/reservas',
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(color: borderColor, thickness: 1),
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_rounded,
                  title: 'Perfil',
                  route: '/perfil',
                  isActive: currentRoute == '/perfil',
                  isPush: false,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings_rounded,
                  title: 'Configuración',
                  route: '/settings',
                  isActive: currentRoute == '/settings',
                  isPush: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    required bool isActive,
    bool isPush = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: isActive ? surfaceColor : Colors.transparent,
        borderRadius: BorderRadius.circular(menuItemRadius),
        child: InkWell(
          onTap: () {
            if (isPush) {
              context.push(route);
            } else {
              context.go(route);
            }
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(menuItemRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: headerHorizontalPadding,
              vertical: menuItemPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(menuItemRadius),
              color: isActive ? surfaceColor : Colors.transparent,
              border: isActive
                  ? Border.all(color: borderColor, width: 1.5)
                  : null,
              boxShadow: isActive ? activeItemShadow : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: isActive ? primaryColor : mutedColor,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: null,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive ? primaryColor : mutedColor,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
