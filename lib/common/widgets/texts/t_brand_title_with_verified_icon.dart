import 'package:flutter/material.dart';
import 'package:leader_app/common/widgets/texts/t_brand_title_text.dart';

import '../../../utils/constants/enumes.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/theme/custom_themes/app_colors.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
  this.textColor,
this.maxLines = 1,
required this.title,
this.iconColor = TColors.PrimaryColor,
this.textAlign = TextAlign.center,
this.brandTextSize = TextSizes.small,
this.isVerified = true,
});

final String title;
final int maxLines;
final Color? textColor, iconColor;
final TextAlign? textAlign;
final TextSizes brandTextSize;
final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

      Flexible(

child: TBrandTitleText(
title: title,
color: textColor,
maxLines: maxLines,
textAlign: textAlign,
brandTextSize: brandTextSize,
),
  ),

const SizedBox (width: TSizes.xs),

if(isVerified)
Icon(Icons.verified, color: iconColor, size: TSizes.iconXs),


    ]);
  }
}
