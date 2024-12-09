import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/layouts/grid_layout.dart';
import 'package:leader_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:leader_app/features/course/controllers/courses_controller.dart';
import 'package:leader_app/features/course/screens/courses_card/courses_card_horizontal.dart';
import 'package:leader_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
class MyCourses extends StatelessWidget {
  const MyCourses( {super.key, });


  @override
  Widget build(BuildContext context) {
        final controller =Get.put(CoursesController()) ;
    return  Scaffold(
      appBar:  TAppBar(title: const Text('categoryCourses.name'), showBackArrow: true),


    
body: SingleChildScrollView(
  child: Column(
    children: [
    FutureBuilder(
      future: controller.getMyCourses(),
       builder: ( context, snapshot) { 
       const loader = TVerticalProductShimmer();
  final widget =   TCloudHelperFunctions.checkMultiRecordState(  snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;
                           final courseCategories = snapshot.data!;
  
                           return Column(
                                      children: [
                                      /// Heading
                                      TGridLayout(
                                          itemCount: courseCategories.length,
                                          mainAxisExtent: 160,
                                         crossAxisCount: 1,
                                          itemBuilder: (context, index) =>
                                               TCoursesCardHorizontal(courses :courseCategories[index]),
                                        ),
                                      ]);
  
        },
  
    )
  
  
  
  
  
  ],),
),

    );
  }
}
