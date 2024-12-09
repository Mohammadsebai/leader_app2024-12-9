import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/personalization/models/course_model.dart';
import 'package:leader_app/features/personalization/models/depatments_model.dart';
import 'package:leader_app/utils/exceptions/firebase_exceptions.dart';
import 'package:leader_app/utils/exceptions/format_exceptions.dart';
import 'package:leader_app/utils/exceptions/platform_exceptions.dart';

class ElearingRepository extends GetxController {
  static ElearingRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  CollectionReference chats = FirebaseFirestore.instance.collection('Universities');


Future<void> addDepatments(String name) async {
try {

Map<String, dynamic> userData = {
      'depatmentName':name,
//       //'field2': 'value2',
//       // Add other fields and values as needed.
     };
 await _db.collection("Universities").doc(userId).collection('depatments').doc().set(userData);

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


Future<List<DepatmensModel>> getAllDepatments() async {
    try {
      final snapshot = await _db.collection('Universities').doc(userId).collection('depatments').get();
      final list = snapshot.docs
          .map((document) => DepatmensModel.fromSnapshot(document))
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


//
Future<void> addCourse(String name ,String idDepatments) async {
try {

Map<String, dynamic> userData = {
      'courseName':name,
     'universityName':userId,
     'depatmentName':idDepatments
//       //'field2': 'value2',
//       // Add other fields and values as needed.
     };
 await _db.collection("Universities").doc(userId).collection('depatments').doc(idDepatments).collection('courses').doc().set(userData);

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


Future<List<CourseModel>> getAllCourse(String depatmentsId) async {
    try {
      final snapshot = await _db.collection('Universities').doc(userId).collection('depatments').doc(depatmentsId).collection('courses').get();
      final list = snapshot.docs
          .map((document) => CourseModel.fromSnapshot(document))
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



  ///---
  ///
  
  Future<void> uploadMediaWeb(
  List<int> fileBytes, 
  String fileName, 
  String type1, 
  String depatmentID, 
  String courseID, 
  String fileType, 

) async {
      String docId = _db.collection('Universities').doc(userId).collection('depatments').doc(depatmentID).collection('courses').doc(courseID).collection(type1).doc().id;

  Reference ref = FirebaseStorage.instance.ref().child('Universities').child(userId)
  .child('depatments').child(depatmentID).child('courses').child(courseID).child(type1).child(docId);

  // Convert List<int> to Uint8List
  Uint8List fileData = Uint8List.fromList(fileBytes);
  
  UploadTask uploadTask = ref.putData(fileData);
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  await saveMediaUrl(downloadUrl, depatmentID, courseID, type1,fileType,File(fileName),docId);
}


  Future<void> uploadMedia(
    File file, 
    String fileType, 
    String type1, 
    String depatmentID, 
    String courseID, 
  ) async {
        String docId = _db.collection('Universities').doc(userId).collection('depatments').doc(depatmentID).collection('courses').doc(courseID).collection(type1).doc().id;

    Reference ref = FirebaseStorage.instance.ref().child('Universities').child(userId)
    .child('depatments').child(depatmentID).child('courses').child(courseID).child(type1).child(docId+file.path.split('/').last);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await saveMediaUrl(downloadUrl, depatmentID, courseID, type1,fileType,file,docId);
  }



  Future<void> saveMediaUrl(
    String url, 
    String depatmentID, 
    String courseID, 
    String type1, 
   String fileType, 
   File file,
    String docId

  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference parentDocumentRef = firestore.collection('Universities').doc(userId);
    CollectionReference subcollectionRef = parentDocumentRef.collection('depatments');
    CollectionReference courseSubcollectionRef = subcollectionRef.doc(depatmentID).collection('courses');
    CollectionReference courseSubcollectionRef1 = courseSubcollectionRef.doc(courseID).collection(type1);
    DocumentReference documentRef = courseSubcollectionRef1.doc(docId);
    documentRef.id;

    await documentRef.set({
       'createdOn': FieldValue.serverTimestamp(),
        'downloadUrl':url,
        'type': fileType,
        'name': file.path.split('/').last, // Extracting file name
      'courseName': courseID,
      'depatmentName': depatmentID,
      'universityName': userId,
      
      
      });
  }

  String _generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  ///
  

}