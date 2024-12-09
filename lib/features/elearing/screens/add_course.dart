// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/elearing/controllers/elearing_controller.dart';
import 'package:leader_app/themes/app_colors_light.dart';
import 'package:searchfield/searchfield.dart';


class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _depatmentNameController =TextEditingController();


  @override
  Widget build(BuildContext context) {
                final controller = Get.put(ElearingController()) ;

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
            
                SizedBox(height: 50),
                 Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => SearchField(
              hint: 'بحث عن اسم التخصص',
              itemHeight: 50,
              maxSuggestionsInViewPort: 3,
              suggestionsDecoration: SuggestionDecoration(
                color: AppColorsLight.kOtherColor,
                borderRadius: BorderRadius.circular(10),
              ),
              controller:_depatmentNameController ,
              suggestions: controller.allDepatments.map((dep) {
                return SearchFieldListItem(
                  dep.depatmentName,
                  item: dep.id, // حفظ dep.id في item
                );
              }).toList(),
              onSuggestionTap: (SearchFieldListItem<String> suggestion) {
               // _depatmentNameController.text = suggestion.item!;
                controller.depatmentIdController.text= suggestion.item!;
              },
            ),
          ),
        ),
      ),
    
                      SizedBox(height: 50,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                            controller: controller.courseController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.local_attraction_outlined),
                              border: InputBorder.none,
                              labelText: ' اسم الماده '
                            ),
                            ),
                          ),
                        ),
                      ),
           SizedBox(height: 50,),
             ElevatedButton(
              onPressed: (){

                  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الإضافة'),
          content: const Text('هل أنت متأكد أنك تريد إضافة هذا القسم؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('تأكيد'),
              onPressed: () async {
                Navigator.of(context).pop();
                await  controller.addCourse(context);
              },
            ),
          ],
        );
      },
    );
              },
              child: Text('حفظ'),
            ),
            ],
          ),
        ),
      ),

  );
  }
}

