import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/news/models/news_model.dart';
import 'package:leader_app/features/personalization/models/university_model.dart';
import 'package:leader_app/utils/exceptions/firebase_exceptions.dart';
import 'package:leader_app/utils/exceptions/platform_exceptions.dart';
class NewsCategoryRepository extends GetxController {
  static NewsCategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  
Future<List<NewsPostModel>> getFeaturedNews( ) async {
try {
  
final snapshot = await _db.collection('News').where('universityID', isEqualTo:userId).get();

return snapshot.docs.map((e) => NewsPostModel.fromSnapshot(e)).toList();
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again ${e.toString()}';
}
}

Future<void>deleteNews(String newsId) async {
try {
  
await _db.collection('News').doc(newsId).delete();
Reference ref = FirebaseStorage.instance.ref().child('news').child('images').child(newsId);
await ref.delete();
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again ${e.toString()}';
}
}


Future<List<NewsPostModel>> getAllFeaturedNews() async {
try {
final snapshot = await _db.collection('News').where('IsFeatured', isEqualTo: true).get();
return snapshot.docs.map((e) => NewsPostModel.fromSnapshot(e)).toList();
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again ${e.toString()}';
}
}



Future<List<NewsPostModel>> fetchProductsByQuery(Query query) async {
try {
final querySnapshot = await query.get();
final List<NewsPostModel> productList = querySnapshot.docs.map((doc) => NewsPostModel.fromQuerySnapshot(doc)).toList();
return productList;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}






///-
Future<UniversityModel> getUserNews(String userId) async {
try {
        final snapshot = await _db.collection('Universities').doc(userId).get();
      if (snapshot.exists) {
        return UniversityModel.fromSnapshot(snapshot);
      } else {
        throw Exception('User not found');
      }

} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again ${e.toString()}';
}
}



}