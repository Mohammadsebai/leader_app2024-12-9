import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:leader_app/features/news/controllers/news_category_controller.dart';
import 'package:leader_app/features/news/screens/news_post_cart.dart';
import 'package:leader_app/utils/constants/sizes.dart';
import 'package:leader_app/utils/helpers/cloud_helper_functions.dart';

class MyNewsScreen extends StatefulWidget {
  const MyNewsScreen({super.key});

  @override
  State<MyNewsScreen> createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
   Future<void> _refresh() async {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
        final controller = Get.put(NewsCategoryController()) ;

    return Scaffold(
      appBar: const TAppBar(
        title: Text('data'),
        showBackArrow: true,
      ),
body:RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                //  Brands
                // CategoryBrands(category: category),
                const SizedBox(height: TSizes.spaceBtwItems),

                //Products--
                FutureBuilder(
                    future:
                        controller.fetchAllFeaturedNews(),
                    builder: (context, snapshot) {
                      /// Helper Function: Handle Loader, No Record, OR ERROR Message
                      final response =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const TVerticalProductShimmer());
                      if (response != null) return response;

                      /// Record Found!
                      final products = snapshot.data!;

                      return Column(
                        children: [
                          const SizedBox(height: TSizes.spaceBtwItems),
                          ListView.separated(
                            itemCount: products.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => NewsPostCart(
                              post: products[index],
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 5,
                              ); // يمكنك استبدال هذا بالفاصل المطلوب
                            },
                          )
                        ],
                      );
                    }),
              ]),
            ),
          ]),
    ) ,
      
    );
  }
}