import 'package:cloud_firestore/cloud_firestore.dart';


///Motel class representing user dato,

class DepatmensModel {

// Keep those values final which you do not want to update

final String id;
String depatmentName;

/// Constructor for DepatmensModel.

DepatmensModel({
required this.id,
required this.depatmentName,

});

/// Helper function to get the full name.

/// Helper function to format phone number.

String get mydepatmentName => (depatmentName);

/// Static function to create an empty user model.
static DepatmensModel empty() => DepatmensModel(id:'',depatmentName:'');

/// Convert model to JSON structure for storing data in Firebase.
Map<String, dynamic> toJson() {
return {
'depatmentName': depatmentName,
};
}

/// Factory method to create a DepatmensModel from a Firebase document snapshot.
factory DepatmensModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document) {
if (document.data() != null) {
final data = document.data()!;

return DepatmensModel(
  id: document.id,
  depatmentName: data['depatmentName']??'',
);
}
return DepatmensModel.empty();
}
}