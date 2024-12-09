
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/user_account/models/user_account_model.dart';
import 'package:leader_app/utils/exceptions/firebase_exceptions.dart';
import 'package:leader_app/utils/exceptions/platform_exceptions.dart';


class SettingsCoursesRepository extends GetxController {
  static SettingsCoursesRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

 /// Get all categories
 /// 
Future<List<UserAccountModel>> getRequest(String courseId) async {
  try {
    final snapshot = await _db.collection('Courses').doc(courseId).get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;

      // استخراج القيم من RequestsRegister
      final requests = data['RequestsRegister'] as List<dynamic>?;
      if (requests != null && requests.isNotEmpty) {
        // استخراج RegisterId من كل خريطة
        final registerIds = requests
            .map((request) => request['RegisterId'] as String)
            .toList();

        if (registerIds.isNotEmpty) {
          final requestSnapshots = await _db
              .collection('users')
              .where(FieldPath.documentId, whereIn: registerIds)
              .limit(4)
              .get();

          return requestSnapshots.docs
              .map((e) => UserAccountModel.fromSnapshot(e))
              .toList();
        }
      }
    }
    return [];
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again: ${e.toString()}';
  }
}

 
///-----
///

Future<void> confirmationRequest(String idFriend ,String courseId) async {
try {
 FirebaseFirestore firestore = FirebaseFirestore.instance;
DocumentReference parentDocumentRef = firestore.collection('Courses').doc(courseId);
 Map<String, dynamic> userData = {
  'RegisteredStudentsID':FieldValue.arrayUnion([idFriend]),
     };
      await parentDocumentRef.update(userData);

} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again ${e.toString()}';
}
}

///--

Future<void> deleteRequest(String idFriend, String courseId) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference parentDocumentRef =
        firestore.collection('Courses').doc(courseId);

    // الحصول على المستند الحالي
    DocumentSnapshot snapshot = await parentDocumentRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> requests = data['RequestsRegister'] as List<dynamic>;

      // البحث عن الخريطة التي تحتوي على RegisterId المحدد
      Map<String, dynamic>? requestToRemove;
      for (var request in requests) {
        if (request['RegisterId'] == idFriend) {
          requestToRemove = request as Map<String, dynamic>;
          break;
        }
      }

      // إذا وجدنا الخريطة، نقوم بإزالتها
      if (requestToRemove != null) {
        await parentDocumentRef.update({
          'RequestsRegister': FieldValue.arrayRemove([requestToRemove])
        });
      }
    }
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again: ${e.toString()}';
  }
}


///----

Future<String?> getImageLink(String idFriend, String courseId) async {
    try {
      final snapshot = await _db.collection('Courses').doc(courseId).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        // استخراج القيم من RequestsRegister
        final requests = data['RequestsRegister'] as List<dynamic>?;
        if (requests != null && requests.isNotEmpty) {
          // البحث عن الخريطة التي تحتوي على RegisterId المحدد
          for (var request in requests) {
            if (request['RegisterId'] == idFriend) {
              // إعادة رابط الصورة
              return request['ImageLink'] as String?;
            }
          }
        }
      }
      return null;
    } catch (e) {
      throw 'Something went wrong. Please try again: ${e.toString()}';
    }
  }



}