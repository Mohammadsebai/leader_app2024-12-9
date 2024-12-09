import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:leader_app/features/course/controllers/courses_controller.dart';
import 'package:leader_app/utils/constants/sizes.dart';
import 'package:leader_app/utils/validators/validation.dart';
import 'package:searchfield/searchfield.dart';

class FormAddCourse extends StatelessWidget {
  const FormAddCourse({super.key,});



  @override
  Widget build(BuildContext context) {
    final addProductController = Get.put(CoursesController());

    return  Scaffold(
      appBar:  TAppBar(
        showBackArrow:  true,
        title:Text(addProductController.category.name),
      ),

      body :SingleChildScrollView(
        child: Column(
          children: [
        
          Obx( (){
                if (addProductController.isLoading.value) return const TVerticalProductShimmer(itemCount: 1,);
        
          return GestureDetector(
           onTap: () {
                 addProductController. changeImage();
              },
                      
            child: Container(
              height: TSizes.xxxl*3,
              width: double.infinity,
                      
              decoration: BoxDecoration(
                
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
          
                child: addProductController.imageFileList != null 
                    ? Image.file(File(addProductController.imageFileList!.path),fit: BoxFit.cover,)
                    : const Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.blue,
                        size: TSizes.iconxl*3,
                      ),
            ),
          
          );
          }
          ),
        
            Form(
                    key: addProductController.addProductFormkey,
            
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
              
              
                       Text('القسم ',),
                       TextFormField(
                         decoration:  InputDecoration(
                           labelText:addProductController.category.name,
                           labelStyle: const TextStyle(),
                           floatingLabelStyle: const TextStyle(),
                           enabled: false
                         ),
                       ),
              
                      const SizedBox(height: TSizes.spaceBtwItems),
              
            
            
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'اسم الدوره',
                          hintText: 'عنوان الدوره',
                        ),
                        controller: addProductController.title,
              
                        validator: (value) => TValidator.validateEmptyText(   'اسم الدوره',value)
                      ),
              
                         const SizedBox(height: TSizes.spaceBtwInputFields),
              
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'وصف الدوره',
                          hintText: 'تفاصيل إضافية عن الدوره',
                        ),
                        controller: addProductController.description,
                        validator: (value) => TValidator.validateEmptyText(  'وصف الدوره',value),
                         maxLines: 6, // عدد الأسطر المرئية
                      ),
                         const SizedBox(height: TSizes.spaceBtwInputFields),
              
              
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'السعر',
                          hintText: ' السعر المطلوب',
                           suffixText: 'دينار', // إضافة النص الثابت هنا
                        ),
                       controller: addProductController.price,
                        validator: (value) => TValidator.validateEmptyText( ' السعر',value),
                        keyboardType: TextInputType.number,
              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'رقم الدفع',
                          hintText: 'رقم المحفظه',
                        ),
                       controller: addProductController.paymentNuber,
                        validator: (value) => TValidator.validateEmptyText( ' رقم الدفع',value),
                        keyboardType: TextInputType.number,
              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: ' ايام الدوره ',
                          hintText: ' احد /ثن ',
                        ),
                       controller: addProductController.courseDays,
                        validator: (value) => TValidator.validateEmptyText( 'courseDays ',value),              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: ' لغة الدوره',
                          hintText: 'عربي ',
                        ),
                       controller: addProductController.courseLanguage,
                        validator: (value) => TValidator.validateEmptyText( ' لغة ',value),              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'وقت المحاضرات ',
                          hintText: ' اي ساعه ',
                        ),
                       controller: addProductController.courseTime,
                        validator: (value) => TValidator.validateEmptyText( ' وقت ',value),              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: ' المده الكامله للدوره',
                          hintText: ' 4شهور',
                        ),
                      controller: addProductController.durationOfTheCourse,
                        validator: (value) => TValidator.validateEmptyText( ' المده الكامله ',value),              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: ' وقت المحاضره الواحده',
                          hintText: ' الواحده وقت المحاضره',
                        ),
                      controller: addProductController.durationOfOneLecture,
                        validator: (value) => TValidator.validateEmptyText( 'الواحده وقت المحاضره',value),
              
                      ),
                       const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: ' عدد المحاضرات',
                          hintText: ' عدد المحاضرات',
                        ),
                      controller: addProductController.numberOfLectures,
                        validator: (value) => TValidator.validateEmptyText( ' عدد المحاضرات ',value),
              
                      ),

                       const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'username للمدرس ',
                          hintText: '  username للمدرس',
                        ),
                      controller: addProductController.teacherID,
                        validator: (value) => TValidator.validateEmptyText( ' للمدرس username ',value),
              
                      ),



                         const SizedBox(height: TSizes.spaceBtwSections),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => addProductController.saveAddProduct(),
                          child: const Text('حفظ و ونشر الدوره '),
                        ),
                      ),
                    ],
                  ),
                ),
                   ),
            ),
          ],
        ),
      ),
      ) ;
    
  }
}