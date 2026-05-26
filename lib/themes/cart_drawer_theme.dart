import 'package:flutter/material.dart';

class CartDrawerTheme {
  // Colores del header del drawer
  static const List<Color> headerGradientColors = [
    Color(0xFF2E7D32),
    Color(0xFF1B5E20),
  ];

  static const Alignment headerGradientBegin = Alignment.topLeft;
  static const Alignment headerGradientEnd = Alignment.bottomRight;

  // Colores del header
  static const Color headerIconColor = Colors.white;
  static const Color headerTitleColor = Colors.white;
  static const Color headerSubtitleColor = Color.fromARGB(179, 255, 255, 255);

  // Estilos de texto del header
  static const TextStyle headerTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerSubtitleStyle = TextStyle(
    color: headerSubtitleColor,
    fontSize: 14,
  );

  // Configuración del icono principal
  static const IconData headerIcon = Icons.shopping_cart;
  static const double headerIconSize = 48.0;

  // Colores de los items del carrito
  static const Color itemTitleColor = Colors.black87;
  static const Color itemSubtitleColor = Colors.black54;
  static const Color itemPriceColor = Color(0xFF2E7D32);

  // Estilo para el texto de total
  static const TextStyle totalLabelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle totalPriceStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF2E7D32),
  );

  // Estilo para el botón
  static const Color buttonBackgroundColor = Color(0xFF2E7D32);
  static const Color buttonTextColor = Colors.white;

  // Padding y espaciado
  static const EdgeInsets headerPadding = EdgeInsets.all(16.0);
  static const EdgeInsets contentPadding = EdgeInsets.all(16.0);
  static const double headerSpacing = 8.0;
  static const double itemSpacing = 12.0;

  // Decoración del header
  static BoxDecoration get headerDecoration {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: headerGradientColors,
        begin: headerGradientBegin,
        end: headerGradientEnd,
      ),
    );
  }

  // Estilo de los ListTile
  static TextStyle get listTileTitleStyle {
    return const TextStyle(
      color: itemTitleColor,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get listTileSubtitleStyle {
    return const TextStyle(
      color: itemSubtitleColor,
    );
  }

  // Estilo para el botón de confirmar
  static ButtonStyle get confirmButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: buttonBackgroundColor,
      foregroundColor: buttonTextColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  // Estilo para el botón de eliminar
  static Color get deleteIconColor => const Color(0xFFD32F2F);
}
