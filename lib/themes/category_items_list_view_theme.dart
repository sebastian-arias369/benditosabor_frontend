import 'package:flutter/material.dart';

class CategoryItemsListViewTheme {
  // Colors
  static const Color appBarBackgroundColor = Colors.white;
  static const Color emptyViewIconColor = Color(0xFFBDBDBD);
  static const Color emptyViewTextColor = Color(0xFF757575);

  // AppBar
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // Main Padding
  static const EdgeInsets mainPadding = EdgeInsets.all(16);

  // Category Card
  static const EdgeInsets categoryCardMargin = EdgeInsets.symmetric(vertical: 16);
  static const double categoryCardElevation = 4;
  static const double categoryCardBorderRadius = 16;
  static const EdgeInsets categoryCardPadding = EdgeInsets.all(24);

  static final RoundedRectangleBorder categoryCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(categoryCardBorderRadius),
  );

  static const BoxDecoration categoryCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(categoryCardBorderRadius)),
  );

  static const double categoryIconSize = 48;
  static const double categoryCardSpacing = 16;

  static const TextStyle categoryTitleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
    letterSpacing: 0.5,
  );

  static const TextStyle categorySubtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF757575),
  );

  // Section Spacing
  static const double sectionSpacing = 24;
  static const double itemsSectionTitleSpacing = 12;

  static const TextStyle itemsSectionTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 0.5,
  );

  // Grid
  static const int gridCrossAxisCount = 2;
  static const double gridCrossAxisSpacing = 12;
  static const double gridMainAxisSpacing = 16;
  static const double gridChildAspectRatio = 0.75;

  // Item Card
  static const double itemCardElevation = 2;
  static const EdgeInsets itemCardMargin = EdgeInsets.zero;
  static const double itemCardBorderRadius = 12;
  static const EdgeInsets itemCardPadding = EdgeInsets.all(12);

  static final RoundedRectangleBorder itemCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(itemCardBorderRadius),
  );

  static const BoxDecoration itemCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(itemCardBorderRadius)),
  );

  // Item Image
  static const double itemImageHeight = 120;
  static const BoxDecoration itemImageDecoration = BoxDecoration(
    color: Color(0xFFF5F5F5),
  );
  static const double itemImageIconSize = 32;
  static const Color itemImageIconColor = Color(0xFFBDBDBD);

  // Item Content
  static const double itemContentSpacing = 8;

  static const TextStyle itemTitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 0.3,
  );

  static const TextStyle itemTitleDisabledStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFBDBDBD),
    letterSpacing: 0.3,
  );

  static const TextStyle itemDescriptionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF757575),
    height: 1.4,
  );

  static const TextStyle itemPriceStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2E7D32),
  );

  static const TextStyle itemPriceDisabledStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: Color(0xFFBDBDBD),
  );

  // Chip (Not Available)
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static final BoxDecoration chipDecoration = BoxDecoration(
    color: Color.fromRGBO(211, 47, 47, 0.85),
    borderRadius: BorderRadius.circular(6),
  );
  static const TextStyle chipTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static const Color chipTextColor = Colors.white;

  // Add Button
  static const EdgeInsets addButtonPadding = EdgeInsets.all(8);
  static const BoxDecoration addButtonDecoration = BoxDecoration(
    color: Color(0xFF2E7D32),
    shape: BoxShape.circle,
  );
  static const double addButtonIconSize = 16;
  static const Color addButtonIconColor = Colors.white;

  // Empty View
  static const EdgeInsets emptyViewPadding = EdgeInsets.symmetric(vertical: 48);
  static const double emptyViewIconSize = 64;
  static const double emptyViewSpacing = 16;

  static const TextStyle emptyViewTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF757575),
  );

  // Error
  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFFD32F2F),
  );
}
