import 'package:flutter/material.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_image.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/app_colors.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,  this.imageUrl='', required this.firstName, required this.lastName,  this.universityName='', required this.depatmentName, required this.userName,
  });

final  String imageUrl;
final  String firstName;
final  String lastName;
final  String universityName;
final  String depatmentName;
final  String userName;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      /// Image
      TRoundedImage(
        imageUrl: imageUrl,
        isNetworkImage: true,
        width: 68,
        height: 68,
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.Light,
      ),

      const SizedBox(width: TSizes.spaceBtwItems),

      /// Title, Price, & Size
      Expanded(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             TBrandTitleWithVerifiedIcon(title: universityName),
             Flexible(
                child: TProductTitleText(
                    title: '$firstName $lastName', maxLines: 1)),

            /// Attributes
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'التخصص :', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '$depatmentName ', style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                  text: ' ,user name: ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '$userName ', style: Theme.of(context).textTheme.bodyLarge),
            ]))
          ]))
    ]);
  }
}
