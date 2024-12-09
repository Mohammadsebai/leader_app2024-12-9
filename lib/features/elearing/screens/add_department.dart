
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/elearing/controllers/elearing_controller.dart';


class AddDepartment extends StatelessWidget {
  const AddDepartment({super.key});

  @override
  Widget build(BuildContext context) {
            final controller = Get.put(ElearingController()) ;

   return Scaffold(
      appBar: AppBar(title: const Text('اضافة تخصص'),
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

                //  const TSectionHeading(
                //     title: 'Friendship requests',
                //   ),

               SizedBox(height: 100),
                      Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 25),
                       child: Container(
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: TextField(
                           controller: controller.depatmentController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.school_outlined),
                              border: InputBorder.none,
                              labelText: 'اسم التخصص'
                            ),
                           ),
                         ),
                       ),
                     ),
        
        SizedBox(height: 200,),
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
                await  controller.addDepatments(context);
              },
            ),
          ],
        );
      },
    );
              },
              
              child: const Text('حفظ'),
            
            ),
            ],
          ),
        ),
      ),
  
  );
  
  }
}

