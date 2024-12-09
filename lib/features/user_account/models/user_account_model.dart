import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccountModel {
String id;
// ignore: non_constant_identifier_names
String email;
String firstName;
String lastName;
String phoneNumber;
String? profilePicture;
String userName;
String? depatmentName;
String? universityName;
String  uid;
List<String>? friendshipRequests;
List<String>? friendsList;


UserAccountModel({
required this.id,
required this.email,
required this.firstName,
required this.lastName,
required this.phoneNumber,
required this.userName,
required this.uid,
this.profilePicture,
this.depatmentName,
this.universityName,
this.friendshipRequests,
this.friendsList,
});

/// Create Empty func for clean code
static UserAccountModel empty() => UserAccountModel(id: '', email: '', firstName: '', lastName: '', phoneNumber: '', userName: '', uid: '');
/// Json Format
toJson() {
return {
'Email': email,
'FirstName': firstName,
'LastName': lastName,
'PhoneNumber': phoneNumber,
'Username': userName ,
'uid': uid,
'ProfilePicture': profilePicture,
'depatmentName': depatmentName,
'universityName': universityName,
'FriendshipRequestsList': friendshipRequests ?? [],
'FriendsList': friendsList ?? [],
};
}

/// Map Json oriented document snapshot from Firebase to Model
factory UserAccountModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
if(document.data() ==null)return UserAccountModel.empty();
final data = document.data()!;
return UserAccountModel(
id: document.id,
email: data['Email'],
firstName: data['FirstName'],
lastName: data['LastName']  ,
phoneNumber: data['PhoneNumber']??'' ,
userName: data['Username'] ,
uid: data['uid'] ,
profilePicture: data['ProfilePicture'] ?? '',
depatmentName: data['depatmentName'] ?? '',
universityName: data['universityName'] ?? '',
friendshipRequests: data['FriendshipRequestsList'] != null ? List<String>.from(data['FriendshipRequestsList']) : [],
friendsList: data['FriendsList'] != null ? List<String>.from(data['FriendsList']) : [],

);
}

factory UserAccountModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
final data = document.data() as Map<String, dynamic>;
return  UserAccountModel(
  id: document.id,
email: data['Email'],
firstName: data['FirstName'],
lastName: data['LastName']  ,
phoneNumber: data['PhoneNumber']??'' ,
userName: data['Username'] ,
uid: data['uid'] ,
profilePicture: data['ProfilePicture'] ?? '',
depatmentName: data['depatmentName'] ?? '',
universityName: data['universityName'] ?? '',
friendshipRequests: data['FriendshipRequestsList'] != null ? List<String>.from(data['FriendshipRequestsList']) : [],
friendsList: data['FriendsList'] != null ? List<String>.from(data['FriendsList']) : [],

);
}
}