import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/category.dart';
import '../../services/category_service.dart';
import '../../services/cart_service.dart';
import '../../themes/category_list_view_theme.dart';
import '../../widgets/base_view.dart';
import '../../widgets/cart_drawer.dart';
import '../../utils/currency_formatter.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  final CategoryService _categoryService = CategoryService();
  final CartService _cartService = CartService();
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    final restaurantId = int.parse(dotenv.env['DEFAULT_RESTAURANT_ID'] ?? '1');
    _futureCategories = _categoryService.getCategoriesByRestaurant(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Menú',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      endDrawer: CartDrawer(cartService: _cartService),
      floatingActionButtonLocation: const _CustomFloatingActionButtonLocation(),
      floatingActionButton: AnimatedBuilder(
        animation: _cartService,
        builder: (context, _) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                backgroundColor: const Color.fromRGBO(46, 125, 50, 1),
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
                      color: const Color.fromARGB(255, 255, 255, 255),
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
      body: Container(
        color: CategoryListViewTheme.backgroundColor,
        child: FutureBuilder<List<Category>>(
          future: _futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              if (categories.isEmpty) {
                return _buildEmptyView();
              }
              return CustomScrollView(
                slivers: [
                  _buildBannerSection(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: CategoryListViewTheme.mainContentPadding,
                      child: Column(
                        children: [
                          const SizedBox(
                              height: CategoryListViewTheme.mainContentTopSpacing),
                          ...categories
                              .map((category) => _buildCategorySection(category)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return _buildErrorView(snapshot.error);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildBannerSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: CategoryListViewTheme.bannerHeight,
        margin: CategoryListViewTheme.bannerMargin,
        decoration: CategoryListViewTheme.bannerDecoration,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(CategoryListViewTheme.bannerBorderRadius),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        CategoryListViewTheme.accentColor,
                        CategoryListViewTheme.highlightColor,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: CategoryListViewTheme.bannerTextOverlayColor,
                  ),
                ),
              ),
              Positioned(
                left: CategoryListViewTheme.bannerContentLeft,
                right: CategoryListViewTheme.bannerContentRight,
                bottom: CategoryListViewTheme.bannerContentBottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Restaurante',
                      style: CategoryListViewTheme.bannerSubtitleStyle,
                    ),
                    const SizedBox(
                        height: CategoryListViewTheme.bannerInternalSpacing1),
                    Text(
                      'Bendito Sabor',
                      style: CategoryListViewTheme.bannerTitleStyle,
                    ),
                    const SizedBox(
                        height: CategoryListViewTheme.bannerInternalSpacing2),
                    Container(
                      padding: CategoryListViewTheme.bannerDescriptionPadding,
                      decoration:
                          CategoryListViewTheme.bannerDescriptionDecoration,
                      child: Text(
                        'Menú del día • Especialidades • Tradición',
                        style: CategoryListViewTheme.bannerDescriptionStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: CategoryListViewTheme.emptyViewIconSize,
            color: CategoryListViewTheme.emptyViewIconColor,
          ),
          const SizedBox(height: CategoryListViewTheme.emptyViewSpacing),
          Text(
            'No hay menú disponible',
            style: CategoryListViewTheme.emptyViewTitleStyle.copyWith(
              color: CategoryListViewTheme.emptyViewTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(Category category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.nombre,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/category/${category.id}');
                  },
                  child: Container(
                    padding: CategoryListViewTheme.viewAllButtonPadding,
                    decoration: BoxDecoration(
                      color: CategoryListViewTheme.viewAllButtonBackgroundColor,
                      borderRadius: BorderRadius.circular(
                          CategoryListViewTheme.viewAllButtonBorderRadius),
                      border: Border.all(
                          color: CategoryListViewTheme.viewAllButtonBorderColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ver todo',
                          style: CategoryListViewTheme.viewAllButtonTextStyle,
                        ),
                        SizedBox(
                            width: CategoryListViewTheme.viewAllButtonSpacing),
                        Icon(
                          Icons.arrow_forward,
                          size: CategoryListViewTheme.viewAllButtonIconSize,
                          color: CategoryListViewTheme.viewAllButtonIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (category.itemsMenu.isEmpty)
            _buildEmptyCategory()
          else
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                itemCount: category.itemsMenu.length,
                itemBuilder: (context, index) {
                  return _buildMenuItemCard(category.itemsMenu[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(ItemMenu item) {
    return Container(
      width: CategoryListViewTheme.cardHorizontalWidth,
      margin: CategoryListViewTheme.cardHorizontalMargin,
      decoration: CategoryListViewTheme.buildCardDecoration(),
      child: Material(
        color: Colors.transparent,
        borderRadius:
            BorderRadius.circular(CategoryListViewTheme.cardBorderRadius),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(CategoryListViewTheme.cardBorderRadius),
          onTap: item.estItem
              ? () {
                  context.push('/item/${item.id}');
                }
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(CategoryListViewTheme.cardBorderRadius),
                  topRight:
                      Radius.circular(CategoryListViewTheme.cardBorderRadius),
                ),
                child: Container(
                  width: double.infinity,
                  height: CategoryListViewTheme.cardImageHeight,
                  color: CategoryListViewTheme.cardImageBackgroundColor,
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
                                strokeWidth:
                                    CategoryListViewTheme.loadingStrokeWidth,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CategoryListViewTheme.loadingColor),
                              ),
                            );
                          },
                        )
                      : _buildPlaceholderImage(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: CategoryListViewTheme.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!item.estItem)
                        Container(
                          padding: CategoryListViewTheme.cardUnavailablePadding,
                          margin: CategoryListViewTheme.cardUnavailableMargin,
                          decoration: CategoryListViewTheme
                              .buildCardUnavailableDecoration(),
                          child: Text(
                            'No disponible',
                            style: CategoryListViewTheme
                                .cardUnavailableTextStyle,
                          ),
                        ),
                      Text(
                        item.nomItem,
                        style: item.estItem
                            ? CategoryListViewTheme.cardTitleStyle
                            : CategoryListViewTheme.cardTitleDisabledStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height: CategoryListViewTheme.cardElementSpacing),
                      Text(
                        item.descItem.isNotEmpty ? item.descItem : 'Chef',
                        style: CategoryListViewTheme.cardDescriptionStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              CurrencyFormatter.formatColombianPrice(
                                  item.precItem),
                              style: item.estItem
                                  ? CategoryListViewTheme.cardPriceStyle
                                  : CategoryListViewTheme.cardPriceDisabledStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.estItem)
                            GestureDetector(
                              onTap: () {
                                _cartService.addItem(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${item.nomItem} agregado al carrito'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: CategoryListViewTheme
                                    .cardButtonSmallPadding,
                                decoration: CategoryListViewTheme
                                    .buildCardButtonSmallDecoration(),
                                child: Icon(
                                  Icons.add,
                                  size:
                                      CategoryListViewTheme.cardButtonSmallIconSize,
                                  color:
                                      CategoryListViewTheme.cardButtonIconColor,
                                ),
                              ),
                            ),
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
    );
  }

  Widget _buildEmptyCategory() {
    return Container(
      height: CategoryListViewTheme.emptyCategoryHeight,
      margin: CategoryListViewTheme.emptyCategoryMargin,
      padding: CategoryListViewTheme.emptyCategoryPadding,
      decoration: CategoryListViewTheme.emptyCategoryDecoration,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu_outlined,
              size: CategoryListViewTheme.emptyCategoryIconSize,
              color: CategoryListViewTheme.emptyCategoryIconColor,
            ),
            SizedBox(height: CategoryListViewTheme.emptyCategorySpacing),
            Text(
              'No hay items en esta categoría',
              style: CategoryListViewTheme.emptyCategoryTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: CategoryListViewTheme.placeholderImageBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: CategoryListViewTheme.placeholderImageIconSize,
            color: CategoryListViewTheme.placeholderImageIconColor,
          ),
          SizedBox(
              height: CategoryListViewTheme.placeholderImageSpacing),
          Text(
            'Sin imagen',
            style: CategoryListViewTheme.placeholderImageTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: CategoryListViewTheme.emptyViewIconSize,
            color: CategoryListViewTheme.errorIconColor,
          ),
          const SizedBox(height: CategoryListViewTheme.emptyViewSpacing),
          Text(
            'Error al cargar el menú',
            style: CategoryListViewTheme.errorTitleStyle,
          ),
          const SizedBox(height: 8),
          Text(
            '$error',
            textAlign: TextAlign.center,
            style: CategoryListViewTheme.errorDescriptionStyle,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final restaurantId = int.parse(
                  dotenv.env['DEFAULT_RESTAURANT_ID'] ?? '1',
                );
                _futureCategories =
                    _categoryService.getCategoriesByRestaurant(restaurantId);
              });
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class _CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _CustomFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final standardOffset =
        FloatingActionButtonLocation.endFloat.getOffset(scaffoldGeometry);
    return Offset(standardOffset.dx, standardOffset.dy - 50.0);
  }
}
