import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/common/widgets/appbar/appbar.dart';
import 'package:leader_app/features/course/models/courses_model.dart';
import 'package:leader_app/features/course/screens/courses_card/call_page.dart';
import 'package:leader_app/features/course/screens/courses_card/file_chat.dart';
import 'package:leader_app/features/course/screens/courses_card/video.dart';
import 'package:leader_app/features/course/screens/requests_register_screen.dart';

import 'package:readmore/readmore.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class CoursesDetailScreen extends StatelessWidget {
  const CoursesDetailScreen({super.key, required this.courses});

final CoursesModel courses;
  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar( showBackArrow: true,),
      
        bottomNavigationBar:
              ElevatedButton(
            onPressed:  (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  CallPage(
                    conferenceID:courses.id!,
                     userID: userId,
                      userName: 'Manager',
                       turnOnCameraWhenJoining: false,
                        turnOnMicrophoneWhenJoining: false,
                         imageuser: '',
                        
                      ))
                  );
            },
            child: const Text(' Start a meeting ')),
          

        body: SingleChildScrollView(
            child: Column(children: [
          /// 1 -Product Image Slider


            SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Center(
                        child:
                        CachedNetworkImage(imageUrl:  courses.thumbnail)
                              ),
                  ),
                ),
                  const SizedBox(height: TSizes.spaceBtwSections),

               ElevatedButton(
              onPressed:  ()=> Get.to( RequestsRegisterScreen(courseId: courses.id!,)),
            child: const Text(' Requests Register')),

                  const SizedBox(height: TSizes.spaceBtwSections),

          ///2 - Product Details
          Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Rating & Share Button
                //  const TRatingAndShare(),

                  /// Price, Title, Stock, & Brand
                   const TSectionHeading(
                    title: 'Title', showActionButton: false), 
                const SizedBox(height: TSizes.spaceBtwItems/2),
               ReadMoreText(
                  courses.title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  Row(
                    children: [
                      const Icon(Icons.timer_outlined,),
                      Text(' Duration of one lecture : ${courses.durationOfOneLecture}')
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Row(
                    children: [
                      const Icon(Icons.play_lesson_outlined,),
                      Text(' Number of Lectures : ${courses.numberOfLectures}')
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.av_timer,),
                      Text(' Duration of The Course : ${courses.durationOfTheCourse}')
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.language,),
                      Text(' Course Language : ${courses.courseLanguage}')
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.date_range_outlined,),
                      Text(' CourseDays : ${courses.courseDays}')
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.access_time,),
                      Text(' CourseTime : ${courses.courseTime}')
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  /// - Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                   ReadMoreText(
                  courses.description??'',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// - Reviews

                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  if (courses.registeredStudentsID != null && courses.registeredStudentsID!.contains(userId))
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    
    const TSectionHeading(title: 'Note : ', showActionButton: false,textColor:Colors.red,),
                               const SizedBox(height: TSizes.spaceBtwItems),

    ReadMoreText(
                  courses.note??'',
                  style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.red),
              
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
             
                  const Divider(),

  ],
),

               //   if (courses.registeredStudentsID != null && courses.registeredStudentsID!.contains(userId))
                    Column(
  children: [
    const TSectionHeading(title: 'Files', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems/2),
    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.filesCourse?.length,
      itemBuilder: (context, index) {   

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatFileWidget(
              filePath: courses.filesCourse![index],
              fileName: 'File ${index + 1}',
              filetype: 'application', // تحديد نوع الملف هنا
            ),
                  const SizedBox(height: TSizes.spaceBtwItems/2),
                  const Divider(),

          ],
        );
      },
    ),
                     const SizedBox(height: TSizes.spaceBtwItems),
// تفصل بين قائمة الملفات والمحتوى التالي
    // هنا يمكنك إضافة المحتوى التالي بعد قائمة الملفات
  ],
),


                 // if (courses.registeredStudentsID != null && courses.registeredStudentsID!.contains(userId))
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.recordVideos!.length,
                    
                      itemBuilder: (context, index) {
                      return Column(
                    children: [
                    Text('فيديو ${index+1}'),
                    ChewieVideoPlayer(videoUrl: courses.recordVideos![index]),
                       const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                       );
                      },
                    
                    ),


                ],
              ))
        ])));
  }
}
