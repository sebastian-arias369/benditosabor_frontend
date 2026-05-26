import 'package:flutter/material.dart';

class ItemDetailViewTheme {
  // Colors
  static const Color primaryOrangeShade600 = Color(0xFF2E7D32);
  static const Color appBarBackgroundColor = Colors.white;
  static const Color priceContainerBackgroundColor = Color(0xFFE8F5E9);
  static const Color priceContainerDisabledColor = Color(0xFFF5F5F5);
  static const Color infoCardBackgroundColor = Color(0xFFFAFAFA);
  static const Color infoCardBorderColor = Color(0xFFE0E0E0);
  static const Color placeholderBackgroundColor = Color(0xFFF5F5F5);
  static const Color errorAppBarColor = Color(0xFFD32F2F);
  static const Color errorAppBarTextColor = Colors.white;
  static const Color errorIconColor = Color(0xFFD32F2F);

  // Icon colors
  static const Color infoCardIconColor = Color(0xFF2E7D32);
  static const Color infoCardRowIconColor = Color(0xFF757575);
  static const Color placeholderIconColor = Color(0xFFBDBDBD);
  static const Color secondaryButtonIconColor = Color(0xFF2E7D32);

  // Text colors
  static const Color notAvailableTextColor = Colors.white;

  // Sizes
  static const double appBarExpandedHeight = 300;
  static const double actionButtonHeight = 56;
  static const double secondaryButtonHeight = 48;
  static const double buttonIconSize = 20;
  static const double secondaryButtonIconSize = 18;
  static const double errorIconSize = 64;
  static const double placeholderIconSize = 80;

  // Spacing
  static const double itemNameSpacing = 16;
  static const double descriptionSpacing = 12;
  static const double infoCardSpacing = 24;
  static const double infoCardTitleSpacing = 12;
  static const double infoRowSpacing = 10;
  static const double buttonSpacing = 12;
  static const double buttonTextSpacing = 8;
  static const double secondaryButtonTextSpacing = 8;
  static const double placeholderSpacing = 16;
  static const double errorSpacing = 16;
  static const double errorDescriptionSpacing = 8;
  static const double errorButtonSpacing = 16;
  static const double errorButtonRowSpacing = 12;

  // Padding
  static const EdgeInsets mainPadding = EdgeInsets.all(16);
  static const EdgeInsets priceContainerPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const EdgeInsets descriptionPadding = EdgeInsets.all(12);
  static const EdgeInsets infoCardPadding = EdgeInsets.all(16);
  static const EdgeInsets notAvailablePadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 6);
  static const EdgeInsets errorPadding = EdgeInsets.all(24);
  static const EdgeInsets errorButtonPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  // Positions
  static const double notAvailableTop = 16;
  static const double notAvailableRight = 16;

  // Text Styles
  static const TextStyle itemNameStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: 0.5,
  );

  static const TextStyle itemNameDisabledStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFBDBDBD),
    letterSpacing: 0.5,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF2E7D32),
  );

  static const TextStyle priceDisabledStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFFBDBDBD),
  );

  static const TextStyle descriptionTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF424242),
    height: 1.5,
  );

  static const TextStyle descriptionPlaceholderStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
    fontStyle: FontStyle.italic,
  );

  static const TextStyle infoCardTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle infoRowLabelStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color(0xFF616161),
  );

  static const TextStyle infoRowValueStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle secondaryButtonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E7D32),
  );

  static const TextStyle errorTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFFD32F2F),
  );

  static const TextStyle errorDescriptionStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF757575),
  );

  static const TextStyle placeholderTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFBDBDBD),
  );

  static const TextStyle notAvailableTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: notAvailableTextColor,
  );

  // Decorations
  static const BoxDecoration imageGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(0, 0, 0, 0.1),
        Color.fromRGBO(0, 0, 0, 0.4),
      ],
    ),
  );

  static const BoxDecoration notAvailableDecoration = BoxDecoration(
    color: Color.fromRGBO(211, 47, 47, 0.85),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  // ✅ Convertido de método a static const
  static const BoxDecoration descriptionDecoration = BoxDecoration(
    color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(
      left: BorderSide(color: Color(0xFF2E7D32), width: 4),
    ),
  );

  // ✅ Convertido de método a static const
  static const BoxDecoration infoCardDecoration = BoxDecoration(
    color: infoCardBackgroundColor,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    border: Border(
      top: BorderSide(color: infoCardBorderColor, width: 1),
      bottom: BorderSide(color: infoCardBorderColor, width: 1),
    ),
  );

  static BoxDecoration priceContainerDecoration(bool isAvailable) {
    return BoxDecoration(
      color: isAvailable
          ? priceContainerBackgroundColor
          : priceContainerDisabledColor,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  static ButtonStyle primaryButtonStyle(bool isAvailable) {
    return ElevatedButton.styleFrom(
      backgroundColor:
          isAvailable ? const Color(0xFF2E7D32) : const Color(0xFFBDBDBD),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: isAvailable ? 4 : 0,
      disabledBackgroundColor: const Color(0xFFBDBDBD),
    );
  }

  // ✅ Correcto — sin const
static final ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: const Color(0xFF2E7D32),
  side: const BorderSide(color: Color(0xFF2E7D32), width: 2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);

static final ButtonStyle errorButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF2E7D32),
  foregroundColor: Colors.white,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

}