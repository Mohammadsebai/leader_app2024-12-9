import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leader_app/features/course/models/category_courses_model.dart';
import 'package:leader_app/features/course/models/courses_model.dart';
import 'package:leader_app/utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CoursesRepository extends GetxController {
  static CoursesRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

 /// Get all categories
  Future<List<CategoryCoursesModel>> getAllCoursesCategories() async {
    try {
      final snapshot = await _db.collection('CoursesCategories').get();
      final list = snapshot.docs
          .map((document) => CategoryCoursesModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



///-----
///


/// Function to save user data to Firestore.
Future<String> saveAddProduct (CoursesModel coures,String category,) async {
try {
 final docRef = await _db.collection("Courses").add(coures.toJson());
 _db.collection("CourseForCategories").add(
  {"CoursesCateggoriesId": category,
   "CoursesId": docRef.id}
 );
 
    return docRef.id;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}


///--
 Future<String>saveImageProduct(XFile image ,String productId) async {
try {
String imageUrl ='';

      File imageFile = File(image.path);
     String fileExtension = image.path.split('.').last; // Get the file extension

    String imageName = 'product_$productId"_".$fileExtension'; // Unique image name
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('coures')
          .child('images')
          .child(imageName);
      await ref.putFile(imageFile);
       imageUrl = await ref.getDownloadURL();
    
  
  return imageUrl;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}




Future<void> saveImageUrls(String coursesId, String imageUrls) async {
  try {
    await _db.collection("Courses").doc(coursesId).update({
      'Thumbnail':imageUrls
    });
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}


  Future<List<CoursesModel>> getMyCourses() async {
    try {
      final snapshot = await _db.collection('Courses').where('ManagerID', isEqualTo: userId).get();
      final list = snapshot.docs
          .map((document) => CoursesModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
