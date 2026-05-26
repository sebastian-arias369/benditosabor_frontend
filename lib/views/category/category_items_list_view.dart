import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/category.dart';
import '../../services/category_service.dart';
import '../../services/cart_service.dart';
import '../../themes/category_items_list_view_theme.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/cart_drawer.dart';

class CategoryItemsListView extends StatefulWidget {
  final String categoryId;

  const CategoryItemsListView({super.key, required this.categoryId});

  @override
  State<CategoryItemsListView> createState() => _CategoryItemsListViewState();
}

class _CategoryItemsListViewState extends State<CategoryItemsListView> {
  final CategoryService _categoryService = CategoryService();
  final CartService _cartService = CartService();
  late Future<Category> _futureCategory;

  @override
  void initState() {
    super.initState();
    _futureCategory = _categoryService.getCategoryById(int.parse(widget.categoryId)).then((category) {
      if (category == null) {
        throw Exception('Categoría no encontrada');
      }
      return category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menú',
          style: CategoryItemsListViewTheme.appBarTitleStyle,
        ),
      ),
      body: FutureBuilder<Category>(
        future: _futureCategory,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final category = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: CategoryItemsListViewTheme.mainPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: CategoryItemsListViewTheme.categoryCardMargin,
                            child: Card(
                              elevation: CategoryItemsListViewTheme.categoryCardElevation,
                              shape: CategoryItemsListViewTheme.categoryCardShape,
                              child: Container(
                                decoration: CategoryItemsListViewTheme.categoryCardDecoration,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      CategoryItemsListViewTheme.categoryCardBorderRadius),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0x1A2E7D32),
                                          Color(0x332E7D32),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Color(0x4D000000),
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: CategoryItemsListViewTheme.categoryCardPadding,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(0, 255, 255, 255),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(51, 221, 212, 212),
                                                    blurRadius: 8,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                _getCategoryIcon(category.nombre),
                                                size: CategoryItemsListViewTheme.categoryIconSize,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                                height: CategoryItemsListViewTheme.categoryCardSpacing),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(0, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0x1A000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                category.nombre.toUpperCase(),
                                                style: CategoryItemsListViewTheme
                                                    .categoryTitleStyle
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(0, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '${category.itemsMenu.length} items para escoger',
                                                style: CategoryItemsListViewTheme
                                                    .categorySubtitleStyle
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: CategoryItemsListViewTheme.sectionSpacing),
                        if (category.itemsMenu.isNotEmpty) ...[
                          const Text(
                            'Items del Menú',
                            style: CategoryItemsListViewTheme.itemsSectionTitleStyle,
                          ),
                          SizedBox(
                              height:
                                  CategoryItemsListViewTheme.itemsSectionTitleSpacing),
                        ],
                      ],
                    ),
                  ),
                ),
                if (category.itemsMenu.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            CategoryItemsListViewTheme.gridCrossAxisCount,
                        crossAxisSpacing:
                            CategoryItemsListViewTheme.gridCrossAxisSpacing,
                        mainAxisSpacing: CategoryItemsListViewTheme.gridMainAxisSpacing,
                        childAspectRatio:
                            CategoryItemsListViewTheme.gridChildAspectRatio,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildItemCard(category.itemsMenu[index]);
                        },
                        childCount: category.itemsMenu.length,
                      ),
                    ),
                  )
                else
                  SliverToBoxAdapter(
                    child: Container(
                      padding: CategoryItemsListViewTheme.emptyViewPadding,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              size: CategoryItemsListViewTheme.emptyViewIconSize,
                              color: CategoryItemsListViewTheme.emptyViewIconColor,
                            ),
                            SizedBox(
                                height: CategoryItemsListViewTheme.emptyViewSpacing),
                            Text(
                              'Esta categoría no tiene items disponibles',
                              style: CategoryItemsListViewTheme.emptyViewTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: CategoryItemsListViewTheme.errorTextStyle,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      endDrawer: const CartDrawer(),
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
                    constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
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

  Widget _buildItemCard(ItemMenu item) {
    return Card(
      elevation: CategoryItemsListViewTheme.itemCardElevation,
      margin: CategoryItemsListViewTheme.itemCardMargin,
      shape: CategoryItemsListViewTheme.itemCardShape,
      child: Container(
        decoration: CategoryItemsListViewTheme.itemCardDecoration,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
              CategoryItemsListViewTheme.itemCardBorderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(
                CategoryItemsListViewTheme.itemCardBorderRadius),
            onTap: item.estItem
                ? () {
                    context.push('/item/${item.id}');
                  }
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        CategoryItemsListViewTheme.itemCardBorderRadius),
                    topRight: Radius.circular(
                        CategoryItemsListViewTheme.itemCardBorderRadius),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: CategoryItemsListViewTheme.itemImageHeight,
                    decoration: CategoryItemsListViewTheme.itemImageDecoration,
                    child: item.imgItemMenu.isNotEmpty
                        ? Image.network(
                            item.imgItemMenu,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderImage(),
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF2E7D32)),
                                ),
                              );
                            },
                          )
                        : _buildPlaceholderImage(),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: CategoryItemsListViewTheme.itemCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!item.estItem)
                          Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: CategoryItemsListViewTheme.chipPadding,
                            decoration: CategoryItemsListViewTheme.chipDecoration,
                            child: Text(
                              'No disponible',
                              style: CategoryItemsListViewTheme.chipTextStyle
                                  .copyWith(
                                color: CategoryItemsListViewTheme.chipTextColor,
                              ),
                            ),
                          ),
                        Text(
                          item.nomItem,
                          style: item.estItem
                              ? CategoryItemsListViewTheme.itemTitleStyle
                              : CategoryItemsListViewTheme.itemTitleDisabledStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height:
                                CategoryItemsListViewTheme.itemContentSpacing),
                        if (item.descItem.isNotEmpty)
                          Flexible(
                            child: Text(
                              item.descItem,
                              style: CategoryItemsListViewTheme
                                  .itemDescriptionStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                CurrencyFormatter.formatColombianPrice(
                                    item.precItem),
                                style: item.estItem
                                    ? CategoryItemsListViewTheme.itemPriceStyle
                                    : CategoryItemsListViewTheme
                                        .itemPriceDisabledStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (item.estItem) ...[
                              const SizedBox(width: 8),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () => _addToCart(item),
                                  child: Container(
                                    padding: CategoryItemsListViewTheme
                                        .addButtonPadding,
                                    decoration: CategoryItemsListViewTheme
                                        .addButtonDecoration,
                                    child: Icon(
                                      Icons.add,
                                      size: CategoryItemsListViewTheme
                                          .addButtonIconSize,
                                      color: CategoryItemsListViewTheme
                                          .addButtonIconColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: CategoryItemsListViewTheme.itemImageDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: CategoryItemsListViewTheme.itemImageIconSize,
            color: CategoryItemsListViewTheme.itemImageIconColor,
          ),
          const SizedBox(height: 4),
          Text(
            'Sin imagen',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
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

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'entradas':
        return Icons.restaurant;
      case 'platos principales':
        return Icons.dinner_dining;
      case 'postres':
        return Icons.cake;
      case 'bebidas':
        return Icons.local_drink;
      default:
        return Icons.restaurant_menu;
    }
  }
}
