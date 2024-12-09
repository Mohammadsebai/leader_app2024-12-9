import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leader_app/common/styles/shadows_style.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_container.dart';
import 'package:leader_app/common/widgets/images_/t_rounded_image.dart';
import 'package:leader_app/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:leader_app/features/news/controllers/news_category_controller.dart';
import 'package:leader_app/features/news/models/news_model.dart';
import 'package:leader_app/features/personalization/models/university_model.dart';
import 'package:leader_app/utils/constants/enumes.dart';
import 'package:leader_app/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/custom_themes/app_colors.dart';

class NewsPostCart extends StatelessWidget {
  const NewsPostCart({super.key, required this.post});
  final NewsPostModel post;
  @override
  Widget build(BuildContext context) {
     final controller =NewsCategoryController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    /// Container with side paddings, color, edges, radius and shadow.
    return FutureBuilder<UniversityModel?>(
      future:  controller.getUserNews(post.universityID??""),
      builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator while waiting for the future to complete
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error case
          return Text('Error: ${snapshot.error}');
        }

        final UniversityModel?  University = snapshot.data;
        return GestureDetector(
          //onTap: ()  => Get.to(() =>  ProductDetailScreen(product: product,)),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [TShadowStyle.verticalProductShadow],
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                color: dark ? TColors.darkerGrey : TColors.white,
              ),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    /// Thumbnail, Wishlist Button, Discount Tag
                    TRoundedImage(
                      imageUrl: University!.profilePicture,
                      applyImageRadius: true,
                      isNetworkImage: true,
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    //Details
                    Padding(
                      padding:
                          const EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
                      child: TBrandTitleWithVerifiedIcon(
                        title: University.universityName,
                        brandTextSize: TextSizes.large,
                      ),
                    ),
                  ]),
                  Padding(
                    //  padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.fromLTRB(140, 8, 0, 0),
                    child: Text(PostDate(post.postTime!)),
                  ),
        
                  const SizedBox(height: TSizes.spaceBtwItems),
        
                  ReadMoreText(
                    post.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '\nShow more....',
                    trimExpandedText: '\n Less',
                    textAlign: TextAlign.right,
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  const SizedBox(height: TSizes.spaceBtwItems),
        
                  /// Image Slider
                  if (post.postImages!.isNotEmpty)
                    Positioned(
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: ListView.separated(
                            itemCount: post.postImages!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (_, __) => const SizedBox(width: 0),
                            itemBuilder: (_, index) => Stack(
                                  children: [
                                    TRoundedImage(
                                      applyImageRadius: false,
                                      borderRadius: 0,
                                      width: 362,
                                      isNetworkImage: true,
                                      imageUrl: post.postImages![index],
                                      // backgroundColor: dark ? TColors.Dark : TColors.white,
                                      //border: Border.all(color:true ? TColors.PrimaryColor : Colors.transparent),
                                    ),
                                    if (post.postImages!.length > 1)
                                      Positioned(
                                        top: 12,
                                        child: TRoundedContainer(
                                          radius: TSizes.sm,
                                          backgroundColor:
                                              TColors.PrimaryColor.withOpacity(0.3),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: TSizes.sm,
                                              vertical: TSizes.xs),
                                          child: Text('${index + 1}/',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .apply(color: TColors.black)),
                                        ),
                                      ),
                                  ],
                                )
                            // }
                            ),
                      ),
                    ),
                  if (post.postImages!.length > 1)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.PrimaryColor.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(' /${post.postImages!.length}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.black)),
                      ),
                    ),

                                      const SizedBox(height: TSizes.spaceBtwItems),

                                      Row(
                                        children: [

                                          IconButton(
                                            onPressed: ()=> showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                        '  متأكد من الحذف ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('الغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                              //  print('-----------------------${message.medias}');
                               controller.deleteNews(post.id!);
                                Navigator.pop(context);
                              } catch (e) {
                                print('Error deleting message and media: $e');
                              }
                            },
                            child: const Text('حذف'),
                          ),
                        ],
                      ),
                    ),
                                           icon:const Icon(Icons.delete,color: Colors.red,)),
                                           const SizedBox(width: TSizes.spaceBtwItems),
                                         
                                         

                                          IconButton(onPressed: (){}, icon:Icon(Icons.edit_sharp,color: Colors.blue,))
                                        ]
                                      )

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

String PostDate(Timestamp postTime) {
  final dateNow = DateTime.now();
  final postDate = postTime.toDate();
  final differenceInDays = dateNow.difference(postDate).inDays;
  final differenceInHours = dateNow.difference(postDate).inHours;
  final differenceInMinutes = dateNow.difference(postDate).inMinutes;
  if (differenceInDays <= 8) {
    if (differenceInDays <= 8 && differenceInDays != 0) {
      return 'منذ $differenceInDays أيام';
    } else if (differenceInHours < 24 && differenceInHours != 0) {
      return 'منذ $differenceInHours ساعات';
    } else {
      return 'منذ $differenceInMinutes دقائق';
    }
  } else {
    return '${postDate.day}/${postDate.month}/${postDate.year}';
  }
}
