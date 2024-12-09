import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCoursesModel {
String id;
String name;
String image;
bool isFeatured;

CategoryCoursesModel({
required this.id,
required this.name,
required this.isFeatured,
required this.image,

});

/// Empty Helper Function
static CategoryCoursesModel empty() => CategoryCoursesModel(id: '', name: '', isFeatured: false,image:'');


/// Convert model to Json structure so that you can store data in Firebase
Map<String, dynamic> toJson() {
return {
'Name': name,
'IsFeatured': isFeatured,
'Image': image,
};
}
/// Map Json oriented document snapshot from Firebase to UserModel

factory CategoryCoursesModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
if (document.data() != null) {
final data = document.data()!;

// Map JSON Record to the Model
return CategoryCoursesModel(
id: document.id,
name: data['Name'] ?? '',
image: data['Image'] ?? '',
isFeatured: data['IsFeatured'] ?? false,
);
} else {
return CategoryCoursesModel.empty();
}
}

}