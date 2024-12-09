
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/elearing/controllers/elearing_controller.dart';
import 'package:searchfield/searchfield.dart';
import 'login_course.dart';
import '../../../themes/app_colors_light.dart';

class AddFile extends StatelessWidget {
  const AddFile({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(ElearingController()) ;
// final String uName;
String dName= '';
 String cName ='';
    return Scaffold(
      appBar: AppBar(title: const Text('اضافة مواد'),
      leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
             
                const SizedBox(height: 30),
                            Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => SearchField(
              hint: 'بحث عن اسم التخصص',
              itemHeight: 50,
              maxSuggestionsInViewPort: 3,
              suggestionsDecoration: SuggestionDecoration(
                color: AppColorsLight.kOtherColor,
                borderRadius: BorderRadius.circular(10),
              ),
              suggestions: controller.allDepatments.map((dep) {
                return SearchFieldListItem(
                 dName = dep.depatmentName,
                  item: dep.id, // حفظ dep.id في item
                );
              }).toList(),
              onSuggestionTap: (SearchFieldListItem<String> suggestion) {
               // _depatmentNameController.text = suggestion.item!;
                controller.depatmentIdController.text= suggestion.item!;
                controller.getAllCourses( suggestion.item!);

              },
            ),
          ),
        ),
      ),

             const SizedBox(height: 30,),
         Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => SearchField(
              hint: 'بحث عن اسم الماده',
              itemHeight: 50,
              maxSuggestionsInViewPort: 3,
              suggestionsDecoration: SuggestionDecoration(
                color: AppColorsLight.kOtherColor,
                borderRadius: BorderRadius.circular(10),
              ),
              suggestions: controller.allCourse.map((dep) {
                return SearchFieldListItem(
             cName= dep.courseName,
                  item: dep.id, // حفظ dep.id في item
                );
              }).toList(),
              onSuggestionTap: (SearchFieldListItem<String> suggestion) {
               // _depatmentNameController.text = suggestion.item!;
                controller.courseIdController.text= suggestion.item!;
              },
            ),
          ),
        ),
      ),




            const SizedBox(height: 50,),
              ElevatedButton(
              onPressed:() => controller.sendFile('ملخصات',context),
              child: const Text('ملخصات'),
            ),
              const SizedBox(height: 30,),
              ElevatedButton(
              onPressed:() =>controller. sendFile('فيديوهات',context),
              child: const Text('فيديوهات'),
            ),
              const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () =>controller. sendFile('سنوات',context),
              child: const Text('سنوات '),
            ),
              const SizedBox(height: 30,),


            ElevatedButton(
               onPressed: ()=>
                Get.to( LoginCourse( universityName:controller.userId,
                depatmentName: controller.depatmentIdController.text,
                courseName:  controller.courseIdController.text, cName: cName, dName:dName,)),
                
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginCourse( 
                //        universityName:controller.userId,
                //         depatmentName: controller.depatmentIdController.text,
                //         courseName:  controller.courseIdController.text,)),
                // );
                
              //  },
          child: const Text('دخول '),
            ),




            ],
          ),
        ),
      ),

  );
  }
}