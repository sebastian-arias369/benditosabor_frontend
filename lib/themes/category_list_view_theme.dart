import 'package:flutter/material.dart';

class CategoryListViewTheme {
  // Colores
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color accentColor = Color.fromRGBO(46, 125, 50, 1);
  static const Color highlightColor = Color.fromRGBO(76, 175, 80, 1);
  static const Color cardBackgroundColor = Colors.white;
  static const Color cardImageBackgroundColor = Color(0xFFE8E8E8);
  static const Color loadingColor = accentColor;
  static const Color emptyViewIconColor = Color(0xFFBDBDBD);
  static const Color emptyViewTextColor = Color(0xFF757575);
  static const Color errorIconColor = Color(0xFFD32F2F);
  static const Color placeholderImageBackgroundColor = Color(0xFFF5F5F5);
  static const Color placeholderImageIconColor = Color(0xFFBDBDBD);
  static const Color emptyCategoryIconColor = Color(0xFFBDBDBD);
  static const Color viewAllButtonBackgroundColor = Colors.white;
  static const Color viewAllButtonBorderColor = accentColor;
  static const Color viewAllButtonIconColor = accentColor;
  static const Color cardUnavailableBackgroundColor = Color(0xFFFFEBEE);
  static const Color cardUnavailableTextColor = Color(0xFFC62828);
  static const Color cardButtonSmallBackgroundColor = accentColor;
  static const Color cardButtonIconColor = Colors.white;

  // Tamaños de fuente
  static const double bannerTitleFontSize = 28;
  static const double bannerSubtitleFontSize = 12;
  static const double bannerDescriptionFontSize = 11;
  static const double cardTitleFontSize = 16;
  static const double cardDescriptionFontSize = 12;
  static const double cardPriceFontSize = 14;
  static const double emptyViewTitleFontSize = 16;
  static const double errorTitleFontSize = 16;
  static const double errorDescriptionFontSize = 13;
  static const double emptyCategoryTextFontSize = 14;
  static const double viewAllButtonTextFontSize = 12;
  static const double viewAllButtonIconSize = 16;

  // Altura y ancho
  static const double bannerHeight = 240;
  static const double cardHorizontalWidth = 200;
  static const double cardImageHeight = 150;
  static const double emptyCategoryHeight = 120;
  static const double emptyViewIconSize = 56;
  static const double errorViewIconSize = 56;
  static const double placeholderImageIconSize = 40;
  static const double emptyCategoryIconSize = 40;
  static const double loadingStrokeWidth = 2.0;
  static const double cardButtonSmallIconSize = 18;

  // Espaciado (padding y margin)
  static const EdgeInsets mainContentPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets cardHorizontalMargin = EdgeInsets.only(right: 12);
  static const EdgeInsets cardPadding = EdgeInsets.all(12);
  static const EdgeInsets bannerMargin = EdgeInsets.all(16);
  static const EdgeInsets bannerContentPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const EdgeInsets bannerDescriptionPadding =
      EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const EdgeInsets emptyCategoryPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets emptyCategoryMargin = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets cardButtonSmallPadding = EdgeInsets.all(8);
  static const EdgeInsets cardUnavailablePadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const EdgeInsets cardUnavailableMargin = EdgeInsets.only(bottom: 8);
  static const EdgeInsets viewAllButtonPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  // Espacios internos
  static const double mainContentTopSpacing = 0;
  static const double bannerInternalSpacing1 = 4;
  static const double bannerInternalSpacing2 = 12;
  static const double emptyViewSpacing = 16;
  static const double emptyCategorySpacing = 8;
  static const double cardElementSpacing = 6;
  static const double placeholderImageSpacing = 8;
  static const double viewAllButtonSpacing = 6;

  // Posición del banner
  static const double bannerContentLeft = 0;
  static const double bannerContentRight = 0;
  static const double bannerContentBottom = 0;

  // Border radius
  static const double bannerBorderRadius = 12;
  static const double cardBorderRadius = 8;
  static const double viewAllButtonBorderRadius = 6;

  // Decoraciones y estilos
  static const String bannerImageAsset = 'assets/images/banner_restaurant.jpg';
  static const Color bannerTextOverlayColor = Color.fromRGBO(0, 0, 0, 0.3);

  // TextStyles
  static const TextStyle bannerTitleStyle = TextStyle(
    fontSize: bannerTitleFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle bannerSubtitleStyle = TextStyle(
    fontSize: bannerSubtitleFontSize,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
    letterSpacing: 0.5,
  );

  static const TextStyle bannerDescriptionStyle = TextStyle(
    fontSize: bannerDescriptionFontSize,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: cardTitleFontSize,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 0.2,
  );

  static const TextStyle cardTitleDisabledStyle = TextStyle(
    fontSize: cardTitleFontSize,
    fontWeight: FontWeight.w600,
    color: Color(0xFFBDBDBD),
    letterSpacing: 0.2,
  );

  static const TextStyle cardDescriptionStyle = TextStyle(
    fontSize: cardDescriptionFontSize,
    fontWeight: FontWeight.w400,
    color: Color(0xFF757575),
  );

  static const TextStyle cardPriceStyle = TextStyle(
    fontSize: cardPriceFontSize,
    fontWeight: FontWeight.bold,
    color: accentColor,
  );

  static const TextStyle cardPriceDisabledStyle = TextStyle(
    fontSize: cardPriceFontSize,
    fontWeight: FontWeight.bold,
    color: Color(0xFFBDBDBD),
  );

  static const TextStyle cardUnavailableTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: cardUnavailableTextColor,
  );

  static const TextStyle emptyViewTitleStyle = TextStyle(
    fontSize: emptyViewTitleFontSize,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle errorTitleStyle = TextStyle(
    fontSize: errorTitleFontSize,
    fontWeight: FontWeight.w600,
    color: errorIconColor,
  );

  static const TextStyle errorDescriptionStyle = TextStyle(
    fontSize: errorDescriptionFontSize,
    fontWeight: FontWeight.w400,
    color: Color(0xFF757575),
  );

  static const TextStyle emptyCategoryTextStyle = TextStyle(
    fontSize: emptyCategoryTextFontSize,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );

  static const TextStyle viewAllButtonTextStyle = TextStyle(
    fontSize: viewAllButtonTextFontSize,
    fontWeight: FontWeight.w600,
    color: accentColor,
    letterSpacing: 0.2,
  );

  static const TextStyle placeholderImageTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFFBDBDBD),
  );

  // Decoraciones
  static BoxDecoration buildCardDecoration() {
    return BoxDecoration(
      color: cardBackgroundColor,
      borderRadius: BorderRadius.circular(cardBorderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration buildCardUnavailableDecoration() {
    return BoxDecoration(
      color: cardUnavailableBackgroundColor,
      borderRadius: BorderRadius.circular(4),
    );
  }

  static BoxDecoration buildCardButtonSmallDecoration() {
    return BoxDecoration(
      color: cardButtonSmallBackgroundColor,
      borderRadius: BorderRadius.circular(6),
    );
  }

  static const BoxDecoration bannerDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const BoxDecoration bannerDescriptionDecoration = BoxDecoration(
    color: Color.fromRGBO(255, 255, 255, 0.2),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  static const BoxDecoration emptyCategoryDecoration = BoxDecoration(
    color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(
      top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
      bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
    ),
  );
}
