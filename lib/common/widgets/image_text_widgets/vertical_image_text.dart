import 'package:flutter/material.dart';
import 'package:leader_app/common/widgets/images_/t_circular_image.dart';


import '../../../utils/constants/sizes.dart';
import '../../../utils/theme/custom_themes/app_colors.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor ,
    this.onTap,
    this.isNetworkImage =true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            //circular icon

            TCircularImage(
image: image,
fit: BoxFit.fitWidth,
padding: TSizes.sm * 1.4,
isNetworkImage: isNetworkImage,
backgroundColor: backgroundColor,
//overlayColor: THelperFunctions.isDarkMode(context) ? TColors.Light : TColors.Dark,
),

            // Container(
            //   width: 56,
            //   height: 56,
            //   padding: const EdgeInsets.all(TSizes.sm),
            //   decoration: BoxDecoration(
            //     color:
            //         backgroundColor ?? (dark ? TColors.black : TColors.white),
            //     borderRadius: BorderRadius.circular(100),
            //   ),
            //   child: Center(
            //     child: Image(
            //         image: AssetImage(image),
            //         fit: BoxFit.cover,
            //         color: dark ? TColors.Light : TColors.Dark),
            //   ),
            // ),

            //Text
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            SizedBox(
                width:TSizes.appBarHeight,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}
