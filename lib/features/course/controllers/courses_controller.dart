import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leader_app/data/repositorie/course/course_repository.dart';
import 'package:leader_app/features/course/models/category_courses_model.dart';
import 'package:leader_app/features/course/models/courses_model.dart';
import 'package:leader_app/utils/constants/image_strings.dart';
import 'package:leader_app/utils/loaders/loaders.dart';
import 'package:leader_app/utils/popups/full_screen_loader.dart';

class CoursesController extends GetxController {
  static CoursesController get instance => Get.find();

  final isLoading = false.obs;
final courseRepository = Get.put(CoursesRepository());
  RxList<CategoryCoursesModel> allCategoriesCourses = <CategoryCoursesModel>[].obs;
  RxList<CoursesModel> allCoursesInCategories = <CoursesModel>[].obs;
  RxList<CoursesModel> allCourses = <CoursesModel>[].obs;
   List<String> recentCourses = [];


///TextEditingController
  final title = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final courseDays = TextEditingController();
  final courseLanguage = TextEditingController();
  final courseTime = TextEditingController();
  final durationOfTheCourse = TextEditingController();
  final durationOfOneLecture = TextEditingController();
  final numberOfLectures = TextEditingController();
  final paymentNuber = TextEditingController();
  final teacherID = TextEditingController();

     GlobalKey<FormState> addProductFormkey =GlobalKey<FormState>(); // Form key for form validation


  final ImagePicker _picker = ImagePicker();
 XFile? imageFileList ;
  late   CategoryCoursesModel category;



@override
  void onInit() {
    getCoursesCategories();
    super.onInit();
  }

  /// -- Load selected category data
  Future<List<CategoryCoursesModel>> getCoursesCategories() async {
    try {
      final subCategories =await courseRepository.getAllCoursesCategories();
         allCategoriesCourses.assignAll(subCategories);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

///-



  

  // void imgFromGallery() async {
  //   try{
  //   isLoading.value = true;
  //  late XFile? selectedImages = await _picker.pickImage();
  //   if (imageFileList == null) {
  //     imageFileList = selectedImages;
  //   } else if (selectedImages != null) {
      
  //     imageFileList = selectedImages;
  //   }
  //   }finally{
  //    isLoading.value=false;
  //   }
  // }

  void changeImage() async {
    try{    isLoading.value = true;

    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imageFileList = selectedImage;
    }
  }finally{
     isLoading.value=false;
    }
  }



Future<List<CoursesModel>> getMyCourses() async {
    try {
      final MyCourses =await courseRepository.getMyCourses();
         allCourses.assignAll(MyCourses);
      return MyCourses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }




void saveAddProduct() async {
  try{
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...',TImages.loading_c);

// Form Validation
      if (!addProductFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }


    final Timestamp utcTime = Timestamp.fromDate(DateTime.now().toUtc());

// Save Authenticated user data in the Firebase Firestore
      final newProduct = CoursesModel(
        managerID: userId,
         title:  title.text.trim(),
           price: double.parse(price.text.trim()),
            thumbnail: '',
             description: description.text.trim(),
             categoryId: category.id,
             isFeatured: true,
               date: utcTime,
   courseDays: courseDays.text.trim(),
   courseLanguage : courseLanguage.text.trim(),
   courseTime: courseTime.text.trim(),
   durationOfTheCourse : durationOfTheCourse.text.trim(),
   durationOfOneLecture : durationOfOneLecture.text.trim(),
   numberOfLectures : numberOfLectures.text.trim(),
   paymentNuber :paymentNuber.text.trim(),
   teacherID : teacherID.text.trim(),
              //  brand:BrandModel(id: 'id', image: 'image', name: 'name',isFeatured: false),
      );
      
          final String courseId = await courseRepository.saveAddProduct(newProduct,category.id);


    final String imageUrls = await courseRepository.saveImageProduct(imageFileList!, courseId);

  //    await addProductRepository.saveAddProduct(newProduct);
    await courseRepository.saveImageUrls(courseId, imageUrls);


//Remove Loader
      TFullScreenLoader.stopLoading();

//Show Success Message

      TLoaders.successSnackBar(
          title: 'تم',
          message: 'تم نشر اعلانك ');
// Move to Verify Email Screen



    //  Get.offAll(() => const NavigationShopingMenu());




  }catch(e){
    TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());

  }finally{
    title.clear();
description.clear();
price.clear();
   courseDays .clear();
   courseLanguage .clear();
   courseTime .clear();
   durationOfTheCourse.clear();
   durationOfOneLecture .clear();
   numberOfLectures .clear();
   paymentNuber.clear();
   teacherID .clear();


  }

}



}