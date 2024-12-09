import 'package:cloud_firestore/cloud_firestore.dart';


///Motel class representing user dato,

class UniversityModel {

// Keep those values final which you do not want to update

final String id;
final String email;
String profilePicture;
String universityName;

/// Constructor for UniversityModel.

UniversityModel({
required this.id,
required this.email,
required this.profilePicture,
required this.universityName,

});

/// Helper function to get the full name.

/// Helper function to format phone number.

String get myUniversityName => (universityName);

/// Static function to create an empty user model.
static UniversityModel empty() => UniversityModel(id:'',email: '', profilePicture: '',universityName:'');

/// Convert model to JSON structure for storing data in Firebase.
Map<String, dynamic> toJson() {
return {
'Email': email,
'ProfilePicture': profilePicture,
'universityName': universityName,
};
}

/// Factory method to create a UniversityModel from a Firebase document snapshot.
factory UniversityModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document) {
if (document.data() != null) {
final data = document.data()!;

return UniversityModel(
  id: document.id,
  email:data['Email']?? '',
  profilePicture: data['ProfilePicture']??'',
  universityName: data['universityName']??'',
);
}
return UniversityModel.empty();
}
}