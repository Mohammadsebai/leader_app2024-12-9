import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/common/widgets/texts/section_heading.dart';
import 'package:leader_app/features/course/controllers/register_controller.dart';
import 'package:leader_app/features/course/screens/courses_card/cart_add_frind/cart_add_frind.dart';
import 'package:leader_app/features/user_account/models/user_account_model.dart';
import 'package:leader_app/utils/constants/sizes.dart';

class RequestsRegisterScreen extends StatelessWidget {
  const RequestsRegisterScreen({super.key, required this.courseId});

final String courseId;
  @override
  Widget build(BuildContext context) {
        final controller = Get.put(RegisterController());

    return  Scaffold(
      appBar: TAppBar(
        title: Text('Register'),
        showBackArrow: true,
      ),


body: SingleChildScrollView(

child: Column(
  children: [


     Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(children: [
                  const TSectionHeading(
                    title: 'Friendship requests',
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  //carts Friendship requests
                  FutureBuilder<List<UserAccountModel>>(
                    future: controller.fetchrequeste(courseId),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserAccountModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CartAddFrind(
                              peopleList: snapshot.data!,
                              courseId: courseId,
                             );
                        }
                      }
                    },
                  ),

                ])
     )
  ],
),


),




    );




  }
}