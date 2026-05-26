import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/cart_service.dart';
import '../utils/currency_formatter.dart';
import '../themes/cart_drawer_theme.dart';

class CartDrawer extends StatelessWidget {
  final CartService? cartService;

  const CartDrawer({this.cartService, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header del drawer
          DrawerHeader(
            decoration: CartDrawerTheme.headerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  CartDrawerTheme.headerIcon,
                  size: CartDrawerTheme.headerIconSize,
                  color: CartDrawerTheme.headerIconColor,
                ),
                const SizedBox(height: CartDrawerTheme.headerSpacing),
                const Text(
                  'Carrito de Compras',
                  style: CartDrawerTheme.headerTitleStyle,
                ),
                const Text(
                  'Resumen de tu pedido',
                  style: CartDrawerTheme.headerSubtitleStyle,
                ),
              ],
            ),
          ),

          // Lista de items
          Expanded(
            child: cartService == null || cartService!.cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'El carrito está vacío',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                          ),
                          child: const Text(
                            'Seguir comprando',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: cartService!.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartService!.cartItems.values.toList()[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Icon(
                            Icons.shopping_bag,
                            color: const Color(0xFF2E7D32),
                          ),
                          title: Text(
                            item.nomItem,
                            style: CartDrawerTheme.listTileTitleStyle,
                          ),
                          subtitle: Text(
                            CurrencyFormatter.formatColombianPrice(item.precItem),
                            style: CartDrawerTheme.listTileSubtitleStyle.copyWith(
                              color: CartDrawerTheme.itemPriceColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: CartDrawerTheme.deleteIconColor,
                            ),
                            onPressed: () {
                              cartService!.removeItem(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.nomItem} eliminado del carrito'),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const Divider(),

          // Resumen y botón de confirmar
          if (cartService != null && cartService!.cartItems.isNotEmpty)
            Padding(
              padding: CartDrawerTheme.contentPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: CartDrawerTheme.totalLabelStyle,
                      ),
                      Text(
                        CurrencyFormatter.formatColombianPrice(
                          cartService?.totalPrice ?? 0,
                        ),
                        style: CartDrawerTheme.totalPriceStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: CartDrawerTheme.confirmButtonStyle,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Funcionalidad de checkout en desarrollo'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text(
                        'Confirmar Pedido',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Seguir Comprando'),
                    ),
                  ),
                ],
              ),
            )
          else if (cartService != null)
            Padding(
              padding: CartDrawerTheme.contentPadding,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: CartDrawerTheme.confirmButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/home');
                  },
                  child: const Text('Volver al Menú'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

