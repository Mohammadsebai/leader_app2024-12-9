import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:leader_app/common/widgets/texts/product_title_text.dart';
import 'package:leader_app/common/widgets/texts/section_heading.dart';
import 'package:leader_app/features/news/controllers/news_controller.dart';
import 'package:leader_app/utils/constants/sizes.dart';
import 'package:leader_app/utils/theme/custom_themes/app_colors.dart';
import 'package:leader_app/utils/validators/validation.dart';

class AddNewsScreen extends StatelessWidget {
  const AddNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final controller = Get.put(AddNewsController());

    return Scaffold(

       appBar:  const TAppBar(
       showBackArrow: true,
        title: Text('controller.subcategory.name'),
      ),



 body: SingleChildScrollView(
   child: Column(
          children: [
             const TSectionHeading(title: ' Add photos to the ad',showActionButton: false,),
             const TProductTitleText(title: 'You can add 30 photos',smallSize: true,),
          Obx( (){
   
                if (controller.isLoading.value) return const TVerticalProductShimmer();
   
          return Container(
            color: TColors.Light,
            child: SizedBox(
              height: 400,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    // childAspectRatio: 3 / 5,
                  ),
              
                     //   itemCount:  _imageFileList?.length  ?? 12,
                    itemCount: controller.imageFileList != null && controller.imageFileList!.length > 0  ? controller.imageFileList!.length +(30-controller.imageFileList!.length) : 30,
                
                // عدد العناصر في الشبكة
                  itemBuilder: (context, index) {
                    return GestureDetector(
                     onTap: () {
                if (controller.imageFileList != null && index < controller.imageFileList!.length) {
                 controller. changeImage(index);
                } else {
                  controller.imgFromGallery();
                }
              },
              
                
                      child: Column(
                        children: [
                          Container(
                            height: TSizes.xxxl,
                            width: TSizes.xxxl,
              
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          
                          
                              child: controller.imageFileList != null && index < controller.imageFileList!.length
                                  ? Image.file(File(controller.imageFileList![index].path))
                                  : const Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: Colors.blue,
                                      size: TSizes.iconxl,
                                    ),
                          ),
              
                            if (index == 0) // فقط للمربع الأول
                         const Text('الصورة الرأسية'), 
                         
                        ],
                      ),
              
                      
                    );
                  },
                ),
              ),
          );
          }
          ),
   
   
   
           const SizedBox(height: TSizes.spaceBtwInputFields),
          
                  Form(
                    key: controller.addNewsFormkey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'وصف الاعلان',
                        hintText: 'تفاصيل إضافية عن الإعلان',
                      ),
                      controller: controller.description,
                     validator: (value) => TValidator.validateEmptyText(  'وصف الاعلان',value),
                       maxLines: 6, // عدد الأسطر المرئية
                    ),
                  ),
                     const SizedBox(height: TSizes.spaceBtwInputFields),
          ]
        ),
 ),


bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: const Text('Next'),
          onPressed: () => controller.saveAddNews()
//           {
            
//             if(controller.imageFileList!.isNotEmpty) {
//             return  controller.saveAddNews();
//             } else{

// Get.snackbar(
//     'تنبيه',
//     'يجب اختيار صورة واحدة على الأقل',
//     backgroundColor: Colors.red,
//     colorText: Colors.white,
//     snackPosition: SnackPosition.BOTTOM,
//   );

//             }
            
//             }
        ),
      ),
    );
  }
}