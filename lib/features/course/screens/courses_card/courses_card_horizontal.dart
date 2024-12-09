import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_container.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_image.dart';
import 'package:leader_app/common/widgets/texts/product_title_text.dart';
import 'package:leader_app/common/widgets/texts/t_product_price_text.dart';
import 'package:leader_app/features/course/models/courses_model.dart';
import 'package:leader_app/features/course/screens/courses_detail.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/app_colors.dart';

class TCoursesCardHorizontal extends StatelessWidget {
  const TCoursesCardHorizontal({super.key, required this.courses});

  final CoursesModel courses;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()  => Get.to(() =>  CoursesDetailScreen(courses: courses,)),
      child: Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.softGrey,
          ),
          child: Row(children: [
            /// Thumbnail
            TRoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.Dark : TColors.Light,
                child: Stack(children: [
                  /// -- Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundedImage(
                      imageUrl: courses.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
      
                  
      
                  //- Favourite Icon Button
                //   Positioned(
                //     top: 0,
                //     right: 0,
                //     child: TFavouriteIcon(
                //       productId: product.id as String,
                //     ),
                //   ),
                ])),
      
            ///Details
            SizedBox(
                width: 172,
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TProductTitleText( title: courses.title, smallSize: true),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                       
                        ],
                      ),
                      const Spacer(),
      
                      ///price Row
                       Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Price
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: TProductPriceText(price: courses.price.toString(),),
                                  ),
                          ],
                        ),
                      ),
      
                    //Add to cart Button
                  
                  ],
                )
                    ])))
          ]
          )
          ),
          
          
      
    );
  }
}
