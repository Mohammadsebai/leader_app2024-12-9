import 'package:cloud_firestore/cloud_firestore.dart';

class NewsPostModel {
String? id;
String universityID;
List<String>? postImages;
String?  description;
Timestamp? postTime;


NewsPostModel({
   this.id,
  required this.universityID,
   this.postTime,
this.postImages,
this.description,
});

/// Empty Helper Function
static NewsPostModel empty() => NewsPostModel(id: '', universityID: '',postTime:null );


/// Convert model to Json structure so that you can store data in Firebase
Map<String, dynamic> toJson() {
return {
'universityID': universityID,
'description': description,
'PostTime': postTime,
'postImages': postImages ?? [],
};
}


/// Map Json oriented document snapshot from Firebase to UserModel
factory NewsPostModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
if (document.data() != null) {
final data = document.data()!;

// Map JSON Record to the Model
return NewsPostModel(
id: document.id,
universityID: data['universityID'] ?? '',
description: data['description'] ?? '',
postTime: data['PostTime'] ?? '',
postImages: data['postImages'] != null ? List<String>.from(data['postImages']) : [],

);
} else {
return NewsPostModel.empty();
}
}


/// Map Json oriented document snapshot from Firebase to UserModel
factory NewsPostModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
final data = document.data() as Map<String, dynamic>;
// Map JSON Record to the Model
return NewsPostModel(
id: document.id,
universityID: data['universityID'] ?? '',
postTime: data['PostTime'] ?? '',
description: data['description'] ?? '',
postImages: data['postImages'] != null ? List<String>.from(data['postImages']) : [],

);
}

}





