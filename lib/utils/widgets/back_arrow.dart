import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/colors/colors.dart';
import '../../resources/icons/icons.dart';
import '../../services/routes/route_service.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.router.pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.primaryWhite.withOpacity(0.67),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.boxShadowColor.withOpacity(0.3),
              blurStyle: BlurStyle.outer,
              blurRadius: 23.68,
            ),
          ],
        ),
        child: SvgPicture.asset(backArrow),
      ),
    );
  }
}
