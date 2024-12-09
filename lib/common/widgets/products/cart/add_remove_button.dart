import 'package:flutter/material.dart';
import 'package:leader_app/common/widgets/icons_/t_circular_icon.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/app_colors.dart';

class TProductQuantityWithAddRemoeButton extends StatelessWidget {
  const TProductQuantityWithAddRemoeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      TCircularIcon(
        icon: Icons.remove,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: THelperFunctions.isDarkMode(context)
            ? TColors.white
            : TColors.black,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.Light,
      ),
      const SizedBox(width: TSizes.spaceBtwItems),
      Text('2', style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(width: TSizes.spaceBtwItems),
      const TCircularIcon(
        icon: Icons.add,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: TColors.white,
        backgroundColor: TColors.PrimaryColor,
      ),
    ]);
  }
}
