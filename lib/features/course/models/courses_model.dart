import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leader_app/features/course/models/request_register_model.dart';

class CoursesModel {
String? categoryId;
String? courseDays;
String? courseLanguage;
String? courseTime;
Timestamp? date;
String? durationOfTheCourse;
String? durationOfOneLecture;
String? description;
List<String>?filesCourse;
String? id;
String? idMeeting;
bool? isFeatured;
String? note;
String? numberOfLectures;
double price;
String? paymentNuber;
List<String>? recordVideos;
List<String>? registeredStudentsID;
String? teacherID;
String? managerID;
String thumbnail;
String title;
List<RequestRegisterModel>? requestsRegister;

CoursesModel({
 this.id,
required this.title,
required this.price,
required this.thumbnail,
this.note,
this.paymentNuber,
this.idMeeting,
this.courseTime,
this.courseLanguage,
this.teacherID,
this.courseDays,
this.durationOfOneLecture,
this.durationOfTheCourse,
this.numberOfLectures,
this.date,
this.recordVideos,
this.registeredStudentsID,
this.filesCourse,
this.isFeatured,
this.categoryId,
this.description,
this.requestsRegister,
this.managerID,

});

/// Create Empty func for clean code
static CoursesModel empty() => CoursesModel(id: '',durationOfTheCourse:'',
durationOfOneLecture:'' ,courseTime:'',title: '', price: 0, thumbnail: '',
teacherID: '',numberOfLectures: '',courseDays:'',courseLanguage:'',paymentNuber:'');
/// Json Format
toJson() {
return {
'Note': note,
'IdMeeting': idMeeting,
'CourseTime': courseTime,
'DurationOfOneLecture': durationOfOneLecture,
'DurationOfTheCourse': durationOfTheCourse,
'Date': date,
'TeacherID': teacherID,
'NumberOfLectures': numberOfLectures,
'Title': title,
'PaymentNuber': paymentNuber,
'Price': price,
'RecordVideos': recordVideos ?? [],
'FilesCourse': filesCourse ?? [],
'RegisteredStudentsID': registeredStudentsID ?? [],
'Thumbnail': thumbnail,
'IsFeatured': isFeatured,
'CategoryId': categoryId,
'Description': description,
'CourseDays': courseDays,
'CourseLanguage': courseLanguage,
'ManagerID': managerID,
'RequestsRegister': requestsRegister != null ? requestsRegister!.map((e) => e.toJson()).toList() : [],

};
}

/// Map Json oriented document snapshot from Firebase to Model
factory CoursesModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
if(document.data() ==null)return CoursesModel.empty();
final data = document.data()!;
return CoursesModel(
id: document.id,
teacherID:data['TeacherID']  ,
managerID:data['ManagerID']  ,
idMeeting:data['IdMeeting']  ,
courseDays:data['CourseDays']  ,
courseTime:data['CourseTime']  ,
paymentNuber:data['PaymentNuber']  ,
durationOfOneLecture:data['DurationOfOneLecture']  ,
durationOfTheCourse:data['DurationOfTheCourse']  ,
date:data['Date']  ,
numberOfLectures:data['NumberOfLectures']  ,
note: data['Note'],
title: data['Title'],
courseLanguage: data['CourseLanguage'],
isFeatured: data['IsFeatured'] ?? false,
price: double.parse((data['Price'] ?? 0.0).toString()),
thumbnail: data['Thumbnail'] ?? '',
categoryId: data['CategoryId'] ?? '',
description: data['Description'] ?? '',
recordVideos: data['RecordVideos'] != null ? List<String>.from(data['RecordVideos']) : [],
filesCourse: data['FilesCourse'] != null ? List<String>.from(data['FilesCourse']) : [],
registeredStudentsID: data['RegisteredStudentsID'] != null ? List<String>.from(data['RegisteredStudentsID']) : [],
requestsRegister: (data['RequestsRegister'] as List<dynamic>).map((e) => RequestRegisterModel.fromJson(e)).toList(),

);
}

factory CoursesModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
final data = document.data() as Map<String, dynamic>;
return  CoursesModel(
  id :document.id,
  note: data['Note'] ??'',
  idMeeting: data['IdMeeting'] ??'',
  managerID: data['ManagerID'] ??'',
  courseLanguage: data['CourseLanguage'] ??'',
  courseTime: data['CourseTime'] ??'',
  durationOfOneLecture: data['DurationOfOneLecture'] ??'',
  durationOfTheCourse: data['DurationOfTheCourse'] ??'',
 date:data['Date']  ??'',
  teacherID: data['TeacherID'] ??'',
  courseDays: data['CourseDays'] ??'',
  numberOfLectures: data['NumberOfLectures'] ??'',
  title: data['Title'] ??'',
isFeatured: data['IsFeatured'] ?? false,
  price: double.parse((data['Price'] ?? 0.0).toString()),
  paymentNuber:data['PaymentNuber'] ??'',
  thumbnail: data['Thumbnail'] ?? '',
  categoryId: data['CategoryId'] ?? '',
  description: data['Description'] ?? '',
  recordVideos: data['RecordVideos'] != null ? List<String>.from(data['RecordVideos']) : [],
  filesCourse: data['FilesCourse'] != null ? List<String>.from(data['FilesCourse']) : [],
  registeredStudentsID: data['RegisteredStudentsID'] != null ? List<String>.from(data['RegisteredStudentsID']) : [],
  requestsRegister: (data['RequestsRegister'] as List<dynamic>).map((e) => RequestRegisterModel.fromJson(e)).toList(),

);
}
}