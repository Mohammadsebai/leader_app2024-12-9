// File: add_product_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leader_app/data/repositorie/news/news_repository.dart';
import 'package:leader_app/features/news/models/news_model.dart';
import 'package:leader_app/features/start_screen.dart';
import 'package:leader_app/utils/constants/image_strings.dart';
import 'package:leader_app/utils/loaders/loaders.dart';
import 'package:leader_app/utils/popups/full_screen_loader.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AddNewsController extends GetxController {


  final description = TextEditingController();
  GlobalKey<FormState> addNewsFormkey =GlobalKey<FormState>(); // Form key for form validation
  final addNewsRepository = Get.put(AddNewsRepository());
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
    final isLoading = false.obs;


  void imgFromGallery() async {
    try{
    isLoading.value = true;
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (imageFileList == null) {
      imageFileList = selectedImages;
    } else if (selectedImages != null) {
      imageFileList!.addAll(selectedImages);
    }
    }finally{
     isLoading.value=false;
    }
  }

  void changeImage(int index) async {
    try{    isLoading.value = true;

    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imageFileList![index] = selectedImage;
    }
  }finally{
     isLoading.value=false;
    }
  }



Future<void> createDynamicLink(String postId,String imageUrl) async {


  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse('https://studentlife2001.page.link/post?postId=$postId'),
    uriPrefix: 'https://studentlife2001.page.link',
    androidParameters: const AndroidParameters(
      packageName: 'com.example.leader_app', // اسم الحزمة الخاص بتطبيقك
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.example.leader_app', // الـ Bundle ID الخاص بتطبيقك
      minimumVersion: '1.0.0',
    //  appStoreId: '123456789', // إذا كان لديك معرف في App Store
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: 'Check out this post!',
      description: 'Amazing content is waiting for you!',
     // if(imageUrl !='')
    imageUrl: imageUrl.isNotEmpty ? Uri.parse(imageUrl) : null, // صورة الرابط
    ),
  );

  final dynamicLink =await FirebaseDynamicLinks.instance.buildShortLink(
    dynamicLinkParams,
     shortLinkType: ShortDynamicLinkType.unguessable,);

  
 await addNewsRepository.createDynamicLink(dynamicLink.shortUrl.toString(), postId);
//  return dynamicLink.shortUrl.toString();

print('11111Generated Link: ${dynamicLink.shortUrl}1111');

}






void saveAddNews() async {
  try{
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...',TImages.loading_c);

// Form Validation
      if (!addNewsFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

    final Timestamp utcTime = Timestamp.fromDate(DateTime.now().toUtc());

// Save Authenticated user data in the Firebase Firestore
      final newNews = NewsPostModel(
             description: description.text.trim(),
             universityID:userId,
             postTime: utcTime,
                     );
   final String newsId = await addNewsRepository.saveAddNews(newNews);

    final List<String> imageUrls = await addNewsRepository.saveImageNews(imageFileList, newsId);

  //    await addProductRepository.saveAddProduct(newProduct);
    await addNewsRepository.saveImageUrls(newsId, imageUrls);

    await createDynamicLink(newsId,imageUrls.first);

//Remove Loader
      TFullScreenLoader.stopLoading();

//Show Success Message
      TLoaders.successSnackBar(
          title: 'تم',
          message: 'تم نشر اعلانك ');
// Move to Verify Email Screen

      Get.offAll(() => const StartScreen());


  }catch(e){
    TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());

  }finally{
description.clear();
imageFileList = [];


  }

}




}