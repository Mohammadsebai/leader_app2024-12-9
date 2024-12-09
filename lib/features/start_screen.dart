import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/elearing/screens/add_course.dart';
import 'package:leader_app/features/elearing/screens/add_file.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/data/repositorie/authentication/authentication_repository.dart';
import 'package:leader_app/features/course/screens/categories_screen.dart';
import 'package:leader_app/features/course/screens/my_courses.dart';
import 'package:leader_app/features/elearing/screens/add_department.dart';
import 'package:leader_app/features/news/screens/add_news_screen.dart';
import 'package:leader_app/features/news/screens/my_news_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('الصفحه الرايسيه'),
        showBackArrow: true,
      ),


      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddDepartment()),
                  );
                },
                child: const Text(' إضافة تخصص'),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddCourse()),
                  );
                },
                child: const Text(' إضافة مواد'),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFile()),
                  );
                },
                child: const Text(' إضافة ملفات'),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () => Get.to(const AddNewsScreen()),
                child: const Text(' إضافة خبر '),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () => Get.to(const MyNewsScreen()),
                child: const Text('  اخباري '),
              ),
                const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () => Get.to(const MyCourses()),
                child: const Text('  دوراتي'),
              ),
                const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () => Get.to(const CategoriesScreen()),
                child: const Text('  اضافة دورات'),
              ),
        
        
        
             const SizedBox(
                height: 40,
              ),
        
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {AuthenticationRepository.instance.logout();}, child: const Text('Logout')),
                  ), // SizedBox
        
               
            ],
          ),
        ),
      ),
    );
  }
}
