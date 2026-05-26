import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/category.dart';
import '../../services/category_service.dart';
import '../../services/cart_service.dart';
import '../../themes/item_detail_view_theme.dart';
import '../../widgets/cart_drawer.dart';
import '../../utils/currency_formatter.dart';

class ProductCategoryDetailView extends StatefulWidget {
  final String itemId;

  const ProductCategoryDetailView({super.key, required this.itemId});

  @override
  State<ProductCategoryDetailView> createState() =>
      _ProductCategoryDetailViewState();
}

class _ProductCategoryDetailViewState extends State<ProductCategoryDetailView> {
  final CategoryService _categoryService = CategoryService();
  final CartService _cartService = CartService();
  late Future<ItemMenu?> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = _getItemById(int.parse(widget.itemId));
  }

  Future<ItemMenu?> _getItemById(int itemId) async {
    try {
      return await _categoryService.getProductById(itemId);
    } catch (e) {
      throw Exception('Error al buscar el producto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ItemMenu?>(
        future: _futureItem,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final item = snapshot.data;
            if (item == null) {
              return _buildNotFoundView();
            }
            return _buildItemDetail(item);
          } else if (snapshot.hasError) {
            return _buildErrorView(snapshot.error);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      endDrawer: CartDrawer(cartService: _cartService),
      floatingActionButton: AnimatedBuilder(
        animation: _cartService,
        builder: (context, _) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                backgroundColor: const Color(0xFF2E7D32),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (_cartService.totalItems > 0)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 20, minHeight: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _cartService.totalItems > 99
                            ? '99+'
                            : '${_cartService.totalItems}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemDetail(ItemMenu item) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: ItemDetailViewTheme.appBarExpandedHeight,
          floating: false,
          pinned: true,
          backgroundColor: ItemDetailViewTheme.appBarBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                item.imgItemMenu.isNotEmpty
                    ? Image.network(
                        item.imgItemMenu,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholderBackground(),
                      )
                    : _buildPlaceholderBackground(),
                Container(
                  decoration: ItemDetailViewTheme.imageGradientDecoration,
                ),
                if (!item.estItem)
                  Positioned(
                    top: ItemDetailViewTheme.notAvailableTop,
                    right: ItemDetailViewTheme.notAvailableRight,
                    child: Container(
                      padding: ItemDetailViewTheme.notAvailablePadding,
                      decoration: ItemDetailViewTheme.notAvailableDecoration,
                      child: const Text(
                        'NO DISPONIBLE',
                        style: ItemDetailViewTheme.notAvailableTextStyle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: ItemDetailViewTheme.mainPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.nomItem,
                        style: item.estItem
                            ? ItemDetailViewTheme.itemNameStyle
                            : ItemDetailViewTheme.itemNameDisabledStyle,
                      ),
                    ),
                    Container(
                      padding: ItemDetailViewTheme.priceContainerPadding,
                      // ✅ Llama al método que sí recibe parámetro
                      decoration: ItemDetailViewTheme.priceContainerDecoration(
                          item.estItem),
                      child: Text(
                        CurrencyFormatter.formatColombianPrice(item.precItem),
                        style: item.estItem
                            ? ItemDetailViewTheme.priceStyle
                            : ItemDetailViewTheme.priceDisabledStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ItemDetailViewTheme.itemNameSpacing),
                if (item.descItem.isNotEmpty) ...[
                  const Text(
                    'Descripción',
                    style: ItemDetailViewTheme.descriptionTitleStyle,
                  ),
                  const SizedBox(
                      height: ItemDetailViewTheme.descriptionSpacing),
                  Container(
                    width: double.infinity,
                    padding: ItemDetailViewTheme.descriptionPadding,
                    // ✅ Ahora es static const, se usa sin ()
                    decoration: ItemDetailViewTheme.descriptionDecoration,
                    child: Text(
                      item.descItem,
                      style: ItemDetailViewTheme.descriptionTextStyle,
                    ),
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: ItemDetailViewTheme.descriptionPadding,
                    // ✅ Ahora es static const, se usa sin ()
                    decoration: ItemDetailViewTheme.descriptionDecoration,
                    child: Text(
                      'Este producto no tiene descripción disponible.',
                      style: ItemDetailViewTheme.descriptionPlaceholderStyle,
                    ),
                  ),
                ],
                const SizedBox(height: ItemDetailViewTheme.infoCardSpacing),
                _buildInfoCard(item),
                const SizedBox(height: ItemDetailViewTheme.infoCardSpacing),
                _buildActionButtons(item),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(ItemMenu item) {
    return Container(
      width: double.infinity,
      padding: ItemDetailViewTheme.infoCardPadding,
      // ✅ Ahora es static const, se usa sin ()
      decoration: ItemDetailViewTheme.infoCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ItemDetailViewTheme.infoCardIconColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Información del Producto',
                style: ItemDetailViewTheme.infoCardTitleStyle,
              ),
            ],
          ),
          const SizedBox(height: ItemDetailViewTheme.infoCardTitleSpacing),
          _buildInfoRow(Icons.restaurant, 'ID del Producto', '#${widget.itemId}'),
          const SizedBox(height: ItemDetailViewTheme.infoRowSpacing),
          _buildInfoRow(
            Icons.inventory,
            'Stock disponible',
            '${item.stock} unidades',
          ),
          const SizedBox(height: ItemDetailViewTheme.infoRowSpacing),
          _buildInfoRow(
            Icons.local_offer,
            'Estado',
            item.estItem ? 'Disponible' : 'No disponible',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: ItemDetailViewTheme.infoCardRowIconColor,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: ItemDetailViewTheme.infoRowLabelStyle,
        ),
        Expanded(
          child: Text(
            value,
            style: ItemDetailViewTheme.infoRowValueStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ItemMenu item) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: ItemDetailViewTheme.actionButtonHeight,
          child: ElevatedButton(
            onPressed: item.estItem ? () => _addToCart(item) : null,
            style: ItemDetailViewTheme.primaryButtonStyle(item.estItem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.estItem ? Icons.check_circle_outline : Icons.block,
                  size: ItemDetailViewTheme.buttonIconSize,
                ),
                const SizedBox(width: ItemDetailViewTheme.buttonTextSpacing),
                Text(
                  item.estItem
                      ? 'Ordenar - ${CurrencyFormatter.formatColombianPrice(item.precItem)}'
                      : 'Producto No Disponible',
                  style: ItemDetailViewTheme.primaryButtonTextStyle,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ItemDetailViewTheme.buttonSpacing),
        SizedBox(
          width: double.infinity,
          height: ItemDetailViewTheme.secondaryButtonHeight,
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.nomItem} agregado a favoritos'),
                  backgroundColor: ItemDetailViewTheme.primaryOrangeShade600,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ItemDetailViewTheme.secondaryButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  color: ItemDetailViewTheme.secondaryButtonIconColor,
                  size: ItemDetailViewTheme.secondaryButtonIconSize,
                ),
                SizedBox(width: ItemDetailViewTheme.secondaryButtonTextSpacing),
                Text(
                  'Agregar a Favoritos',
                  style: ItemDetailViewTheme.secondaryButtonTextStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ItemDetailViewTheme.placeholderBackgroundColor,
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: ItemDetailViewTheme.placeholderIconSize,
              color: ItemDetailViewTheme.placeholderIconColor,
            ),
            SizedBox(height: ItemDetailViewTheme.placeholderSpacing),
            Text(
              'Sin imagen disponible',
              style: ItemDetailViewTheme.placeholderTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto no encontrado'),
        backgroundColor: ItemDetailViewTheme.errorAppBarColor,
        foregroundColor: ItemDetailViewTheme.errorAppBarTextColor,
      ),
      body: Center(
        child: Padding(
          padding: ItemDetailViewTheme.errorPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: ItemDetailViewTheme.errorIconSize,
                color: ItemDetailViewTheme.errorIconColor,
              ),
              const SizedBox(height: ItemDetailViewTheme.errorSpacing),
              Text(
                'Producto no encontrado',
                style: ItemDetailViewTheme.errorTitleStyle,
              ),
              const SizedBox(
                  height: ItemDetailViewTheme.errorDescriptionSpacing),
              Text(
                'El producto que buscas no existe o ha sido eliminado.',
                textAlign: TextAlign.center,
                style: ItemDetailViewTheme.errorDescriptionStyle,
              ),
              const SizedBox(height: ItemDetailViewTheme.errorButtonSpacing),
              ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al Menú'),
                style: ItemDetailViewTheme.errorButtonStyle.copyWith(
                  padding: WidgetStateProperty.all(
                      ItemDetailViewTheme.errorButtonPadding),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(Object? error) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: ItemDetailViewTheme.errorAppBarColor,
        foregroundColor: ItemDetailViewTheme.errorAppBarTextColor,
      ),
      body: Center(
        child: Padding(
          padding: ItemDetailViewTheme.errorPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: ItemDetailViewTheme.errorIconSize,
                color: ItemDetailViewTheme.errorIconColor,
              ),
              const SizedBox(height: ItemDetailViewTheme.errorSpacing),
              Text(
                'Error al cargar el producto',
                style: ItemDetailViewTheme.errorTitleStyle,
              ),
              const SizedBox(
                  height: ItemDetailViewTheme.errorDescriptionSpacing),
              Text(
                '$error',
                textAlign: TextAlign.center,
                style: ItemDetailViewTheme.errorDescriptionStyle,
              ),
              const SizedBox(height: ItemDetailViewTheme.errorButtonSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _futureItem =
                            _getItemById(int.parse(widget.itemId));
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                    style: ItemDetailViewTheme.errorButtonStyle,
                  ),
                  const SizedBox(
                      width: ItemDetailViewTheme.errorButtonRowSpacing),
                  OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Volver'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(ItemMenu item) {
    _cartService.addItem(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${item.nomItem} agregado al carrito',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Ver Carrito',
          textColor: Colors.white,
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ),
    );
  }
}