import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../utils/currency_formatter.dart';

class CartDrawer extends StatelessWidget {
  final CartService? cartService;

  const CartDrawer({this.cartService, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Carrito de compras',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Divider(),
            Expanded(
              child: cartService == null || cartService!.cartItems.isEmpty
                  ? const Center(
                      child: Text('El carrito está vacío'),
                    )
                  : ListView.builder(
                      itemCount: cartService!.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartService!.cartItems.values.toList()[index];
                        return ListTile(
                          title: Text(item.nomItem),
                          subtitle: Text(
                            CurrencyFormatter.formatColombianPrice(item.precItem),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartService!.removeItem(item.id);
                            },
                          ),
                        );
                      },
                    ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:'),
                      Text(
                        CurrencyFormatter.formatColombianPrice(
                          cartService?.totalPrice ?? 0,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cartService == null || cartService!.cartItems.isEmpty
                          ? null
                          : () {},
                      child: const Text('Confirmar pedido'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
