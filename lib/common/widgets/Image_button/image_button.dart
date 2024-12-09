import 'package:flutter/widgets.dart';
import 'package:leader_app/common/styles/shadows_style.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_container.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_image.dart';
import 'package:leader_app/common/widgets/texts/product_title_text.dart';
import 'package:leader_app/utils/constants/sizes.dart';
import 'package:leader_app/utils/helpers/helper_functions.dart';
import 'package:leader_app/utils/theme/custom_themes/app_colors.dart';

class TImageButton extends StatelessWidget {
  const TImageButton({super.key, required this.imagePath,  
  this.buttonTitle, 
  this.onTap,
   this.textColor,
     this.backgroundColor =TColors.softGrey, 
      this.backgroundSizeWidth=180,
       this.backgroundSizeHeight=180,
       this.width=180,
        this.isNetworkImage = false,
       
       });

 final String  imagePath;
 final String? buttonTitle;
  final void Function()? onTap;
  final Color? textColor;
  final Color backgroundColor;
  final double backgroundSizeWidth;
  final double backgroundSizeHeight;
  final double width;
  final bool isNetworkImage;
  

  @override
  Widget build(BuildContext context) {
     final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
onTap:onTap,
child: Container(
      width: width,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.grey,
        ),


        child: Column(children: [
          //Detailss
           TProductTitleText( title: buttonTitle!, smallSize: false,textAlign:TextAlign.center,),
          /// Thumbnail, Wishlist Button, Discount Tag
          TRoundedContainer(
            height: backgroundSizeWidth,
            width: backgroundSizeHeight,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.Dark :backgroundColor,
            child: Stack(children: [
              ///-- Thumbnail Image

                Center(
                  child: TRoundedImage(
                    imageUrl: imagePath, applyImageRadius: true,isNetworkImage: isNetworkImage,),
                ),



            ])) ,
        ]),
)
    );
  }
}