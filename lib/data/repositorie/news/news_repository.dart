import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:leader_app/features/news/models/news_model.dart';
import 'package:leader_app/utils/exceptions/firebase_exceptions.dart';
import 'package:leader_app/utils/exceptions/format_exceptions.dart';
import 'package:leader_app/utils/exceptions/platform_exceptions.dart';

class AddNewsRepository extends GetxController {

static AddNewsRepository get instance => Get.find();

/// Firestore instance for database interactions.

final _db = FirebaseFirestore.instance;


/// Function to save user data to Firestore.
Future<String> saveAddNews(NewsPostModel news) async {
try {
 final docRef = await _db.collection("News").add(news.toJson());
//  _db.collection("ProductCategory").add(
//   {"categoryId": category,
//    "productId": docRef.id}
//  );
//  _db.collection("ProductCategory").add(
//   {"categoryId": subcategory,
//    "productId": docRef.id}
//  );
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


Future<void> createDynamicLink(String  dynamicLink  ,String idNews) async {
try {
 await _db.collection("News").doc(idNews).update(
  {"DynamicLink": dynamicLink}
 );

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
 Future<List<String>>saveImageNews(List<XFile>? listImage ,String newsId) async {
try {
List<String> imageUrls = [];
    if (listImage != null) {
      for (int i = 0; i < listImage.length; i++) {

        File imageFile = File(listImage[i].path);
       String fileExtension = listImage[i].path.split('.').last; // Get the file extension

      String imageName = 'news_$newsId"_"$i.$fileExtension'; // Unique image name

        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('news')
            .child('images')
            .child(newsId)
            .child(imageName);
        await ref.putFile(imageFile);  

        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }

  return imageUrls;
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



Future<void> saveImageUrls(String newsId, List<String> imageUrls) async {
  try {
    await _db.collection("News").doc(newsId).update({
      'postImages': imageUrls,
    //  'Thumbnail':imageUrls[0]
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
}