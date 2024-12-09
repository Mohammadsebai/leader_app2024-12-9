
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
class FileCourse extends StatefulWidget {

    final String universityName;
  final String depatmentName;
  final String courseName;
  final String type;
  const FileCourse({Key? key,
   required this.universityName,
    required this.depatmentName,
    required this.courseName,
    required this.type}) : super(key: key);
  @override
  State<FileCourse> createState() => _FileCourseState();
}
class _FileCourseState extends State<FileCourse> {


  CollectionReference chats = FirebaseFirestore.instance.collection('Universities');

Future<void> deleteMessage(String fileId, String downloadUrl) async {
  try {
    // Show a confirmation dialog
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحذف'),
          content: Text('$fileIdهل أنت متأكد أنك تريد حذف هذا الملف؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled the operation
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed the operation
              },
              child: Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Get the document reference
      final doc = await chats
          .doc(widget.universityName)
          .collection('depatments')
          .doc(widget.depatmentName)
          .collection('courses')
          .doc(widget.courseName)
          .collection(widget.type)
          .doc(fileId)
          .get();

      if (doc.exists) {
        // Delete the document
        await doc.reference.delete();
        print('Message deleted successfully');

        // Delete the associated media
        await deleteMedia(downloadUrl);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تم الحذف',
              style: TextStyle(color: Colors.red),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        throw Exception('Message not found');
      }
    }
  } catch (e) {
    print('Error deleting message and media: $e');
  }
}



  Future<void> deleteMedia(String mediaUrl) async {
    try {
      final storageRef = FirebaseStorage.instance.refFromURL(mediaUrl);
      await storageRef.delete();
      print('Media deleted successfully');
      
       const SnackBar(
    content: Text(
      'تم الحذف',
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 3),
  );
    } catch (e) {
      print('Error deleting media: $e');
    }
  }



Future<void> callChatDetailScreen(BuildContext context, String downloadUrl, String uid) async {
  try {
      String mimeType = lookupMimeType(downloadUrl) ?? 'application/octet-stream';
  //    if (await canLaunch(downloadUrl)) {
        await launch(downloadUrl);
     // } else {
        // If the URL cannot be launched, try using the open_file package
       await OpenFile.open(downloadUrl, type: mimeType);
     // }
    } catch (e) {
      print('Error opening file: $e');
      // Handle the error, show a snackbar, or display an error message to the user
    } 
}
  @override
  Widget build(BuildContext context) {
     String type = widget.type;
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection('Universities').doc(widget.universityName)
      .collection('depatments').doc(widget.depatmentName).collection('courses').doc(widget.courseName).collection(widget.type)
      .snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Loding'),
          );
        }
        if(snapshot.hasData){
          return CustomScrollView(
            slivers: [
               SliverList(
                  delegate:SliverChildListDelegate(
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String,dynamic> data = document.data()as Map<String, dynamic>;
                  return CupertinoListTile(
                    leadingSize :60,
                    leading: CircleAvatar(
                      radius: 25,
                      child:  type == 'فيديوهات'
                     ? Image.asset('images/video.png')
                     : Image.asset('images/file.jpg'),
                    ),
                    onTap: () 
                    =>
                     callChatDetailScreen( context,
                          data['downloadUrl'] != null ? data['downloadUrl'] : '',
                           document.id),
                    title: Text( data['name']),
                     trailing: IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed: ()  async {
            try {
          //  print('-----------------------${message.medias}');
             deleteMessage( document.id,data['downloadUrl']);
             // deleteMedia(data['downloadUrl']);
               

              

            } catch (e) {
              print('Error deleting message and media: $e');
            }
            },
                          )
                    );
                }
                ).toList()
               ))
            ],
          );
        }
        return Container();
      })
    
    );
  }
}
