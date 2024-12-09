import 'package:cloud_firestore/cloud_firestore.dart';


///Motel class representing user dato,

class CourseModel {

// Keep those values final which you do not want to update

final String id;
String courseName;

/// Constructor for CourseModel.

CourseModel({
required this.id,
required this.courseName,

});

/// Helper function to get the full name.

/// Helper function to format phone number.

String get mycourseName => (courseName);

/// Static function to create an empty user model.
static CourseModel empty() => CourseModel(id:'',courseName:'');

/// Convert model to JSON structure for storing data in Firebase.
Map<String, dynamic> toJson() {
return {
'courseName': courseName,
};
}

/// Factory method to create a CourseModel from a Firebase document snapshot.
factory CourseModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document) {
if (document.data() != null) {
final data = document.data()!;

return CourseModel(
  id: document.id,
  courseName: data['courseName']??'',
);
}
return CourseModel.empty();
}
}