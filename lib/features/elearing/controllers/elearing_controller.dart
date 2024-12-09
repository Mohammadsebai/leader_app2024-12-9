import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/data/repositorie/elearing/elearing_repositiorie.dart';
import 'package:leader_app/features/personalization/models/course_model.dart';
import 'package:leader_app/features/personalization/models/depatments_model.dart';
import 'package:leader_app/utils/loaders/loaders.dart';
import 'package:mime/mime.dart';

class ElearingController extends GetxController {
  static ElearingController get instance => Get.find();

  final isLoading = false.obs;
  final elearingRepository = Get.put(ElearingRepository());
  final depatmentController = TextEditingController();
  final courseController = TextEditingController();
  final depatmentIdController = TextEditingController();
  final courseIdController = TextEditingController();
  RxList<DepatmensModel> allDepatments = <DepatmensModel>[].obs;
  RxList<CourseModel> allCourse = <CourseModel>[].obs;
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    getAllDepatments();
    super.onInit();
  }

  Future<void> addDepatments(BuildContext context) async {
    try {
      isLoading.value = true;
      await elearingRepository.addDepatments(depatmentController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم الاضافة',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCourse(BuildContext context) async {
    try {
      isLoading.value = true;
      await elearingRepository.addCourse(courseController.text, depatmentIdController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم الاضافة',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllDepatments() async {
    try {
      isLoading.value = true;
      final departments = await elearingRepository.getAllDepatments();
      allDepatments.assignAll(departments);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllCourses(String depatmentId) async {
    try {
      isLoading.value = true;
      final courses = await elearingRepository.getAllCourse(depatmentId);
      allCourse.assignAll(courses);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> sendFile(String type,context) async {
        try {

    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      PlatformFile file = filePickerResult.files.first;
      if (kIsWeb) {
        List<int> fileBytes = file.bytes!;
        await elearingRepository.uploadMediaWeb(
          fileBytes, 
          file.name, 
          type, 
          depatmentIdController.text, 
          courseIdController.text, 
          type
        );
      } else {
        final filePath = file.path!;
        final fileType = lookupMimeType(filePath) ?? 'application/octet-stream';
        await elearingRepository.uploadMedia(
          File(filePath), 
          fileType, 
          type, 
          depatmentIdController.text, 
          courseIdController.text, 
          
        );
        
      }
    }
     } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم الاضافة',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  
  }

  @override
  void dispose() {
    depatmentController.dispose();
    courseController.dispose();
    depatmentIdController.dispose();
    courseIdController.dispose();
    super.dispose();
  }
}
