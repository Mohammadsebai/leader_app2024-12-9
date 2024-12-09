import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/Image_button/image_button.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/common/widgets/layouts/grid_layout.dart';
import 'package:leader_app/common/widgets/loaders/animation_loader.dart';
import 'package:leader_app/features/course/controllers/courses_controller.dart';
import 'package:leader_app/features/course/screens/form_add_course.dart';
import 'package:leader_app/utils/constants/image_strings.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
            final controller = Get.put(CoursesController());

    return  Scaffold(
      appBar:TAppBar(title: Text('Courses Categories'),showBackArrow: true,),


body: Column(
  children: [

          Obx(() {
           
             // if (controller.isLoading.value) return const TVerticalProductShimmer();
            if (controller.allCategoriesCourses.isEmpty) {
           return   const TAnimationLoaderWidget(
                      text: '...',
                      animation: TImages.loading_c,
                      showAction: true,                     
                    );
              
            }
            controller.getCoursesCategories();
            return TGridLayout( 

              mainAxisExtent: 230,
              itemCount: controller.allCategoriesCourses.length,
              crossAxisCount: 2,
              itemBuilder: (_, index) {
                final categoryCourses =controller.allCategoriesCourses[index];

                return TImageButton(
              imagePath:categoryCourses.image,
              isNetworkImage: true,
              buttonTitle: categoryCourses.name,
              onTap: () {
                controller.category = controller.allCategoriesCourses[index];
                Get.to(() => const FormAddCourse());
                 }
            );

              }

            );
          })


],),



    );
  }
}