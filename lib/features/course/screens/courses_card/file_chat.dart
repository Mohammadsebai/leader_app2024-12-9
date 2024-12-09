import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:mime/mime.dart';

class ChatFileWidget extends StatelessWidget {
  final String filePath;
  final String fileName;
  final String filetype;

  const ChatFileWidget({super.key, required this.filePath, required this.fileName, required this.filetype});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fileName),
      onTap: () => _openFile(context),
    );
  }

Future<void> _openFile(BuildContext context) async {
    try {
      String mimeType = lookupMimeType(filePath) ?? '1application/octet-stream';
      if (await canLaunch(filePath)) {
        await launch(filePath);

      } else {
        // If the URL cannot be launched, try using the open_file package
        await OpenFile.open(filePath, type: mimeType);

      }
    } catch (e) {
      print('Error opening file: $e');
      // Handle the error, show a snackbar, or display an error message to the user
    }
  }
}
