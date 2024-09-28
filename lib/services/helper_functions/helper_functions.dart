import 'package:flutter/material.dart';

import '../../resources/colors/colors.dart';

class HelperFunctions {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: ColorPalette.secondaryBlack,
              ),
        ),
        backgroundColor: ColorPalette.primaryColor.withOpacity(0.3),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
