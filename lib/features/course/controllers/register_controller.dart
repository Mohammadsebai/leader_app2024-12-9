
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/data/repositorie/course/settings_course_repositorie.dart';
import 'package:leader_app/features/user_account/models/user_account_model.dart';
import 'package:leader_app/utils/loaders/loaders.dart';


class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  final isLoading = false.obs;
  final peopleRepository = Get.put(SettingsCoursesRepository());
  bool  isAddFriend = true;
  RxList<UserAccountModel> peopleList = <UserAccountModel>[].obs;
 RxList<UserAccountModel> requestList = <UserAccountModel>[].obs;
// RxList<UserAccountModel> friendList = <UserAccountModel>[].obs;

  @override
  void onInit() {
    //fetchPeople();
    super.onInit();
  }

Future<List<UserAccountModel>> fetchrequeste(String courseId) async {
  try {
    isLoading.value = true;
    final products = await peopleRepository.getRequest(courseId);
    requestList.assignAll(products);
    return products;
  } catch (e) {
    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return [];
  } finally {
    isLoading.value = false;
  }
}

 Future<void> confirmationRequest(String idFriend ,String courseId ) async {
    try {isLoading.value = true;
      await peopleRepository.confirmationRequest(idFriend ,courseId);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally {
      isLoading.value = false;
    }
  }


//
 Future<void> deleteRequest(String idFriend ,String courseId) async {
    try {isLoading.value = true;
      await peopleRepository.deleteRequest(idFriend,courseId);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally {
      isLoading.value = false;
    }
  }


  ///--
 Future<String?> getImageLink(String idFriend ,String courseId) async {
    try {isLoading.value = true;
      return await peopleRepository.getImageLink(idFriend,courseId);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally {
      isLoading.value = false;
    }
    return null;
  }



// Future<List<UserAccountModel>> fetchAllRequeste() async {
//   try {
//     isLoading.value = true;
//     final products = await peopleRepository.getAllRequest();
//     requestList.assignAll(products);
//     return products;
//   } catch (e) {
//     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     return [];
//   } finally {
//     isLoading.value = false;
//   }
// }



//

//  Future<void> deleteRequest(String idFriend) async {
//     try {isLoading.value = true;
//       await peopleRepository.deleteRequest(idFriend);

//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     }finally {
//       isLoading.value = false;
//     }
//   }
//   //
//  Future<void> confirmationRequest(String idFriend) async {
//     try {isLoading.value = true;
//       await peopleRepository.confirmationRequest(idFriend);

//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     }finally {
//       isLoading.value = false;
//     }
//   }


// Future<List<UserAccountModel>> fetchPeople() async {
//   try {
//     isLoading.value = true;
//     final products = await peopleRepository.getPeople();
//     peopleList.assignAll(products);
//     return products;
//   } catch (e) {
//     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     return [];
//   } finally {
//     isLoading.value = false;
//   }
// }

//   final UsernameController = TextEditingController();
//   Rx<List<UserAccountModel>> searchStream = Rx<List<UserAccountModel>>([]);

//   void searchFetchPeople(String username) async {
//     try {
//       isLoading.value = true;
//       final products = await peopleRepository.getPeopleSearch(username);
//       searchStream.value = products;
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

// //
//   Future<void> sendRequest(String idFriend) async {
//     try {isLoading.value = true;
//       await peopleRepository.sendRequest(idFriend);

//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     }finally {
//       isLoading.value = false;
//     }
//   }
// //
//   Future<void> cancelRequest(String idFriend) async {
//     try {isLoading.value = true;
//       await peopleRepository.cancelRequest(idFriend);

//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     }finally {
//       isLoading.value = false;
//     }
//   }
// //
//   Future<bool> isSendRequest(String idFriend) async {
//     try {isLoading.value = true;
//       isAddFriend = await peopleRepository.isSendRequest(idFriend);

//      return isAddFriend;
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//        return false;
//     }finally {
//       isLoading.value = false;
//     }
//   }






}