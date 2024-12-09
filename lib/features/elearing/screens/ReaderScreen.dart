
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:mime/mime.dart';

class ReaderScreen extends StatefulWidget {
  final String filePath;
  final String fileName;

  ReaderScreen({required this.filePath, required this.fileName});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
       title: Text(widget.fileName),
       onTap: () => _openFile(context),
    );
  }
  
  
  @override
  void initState() {
    super.initState();
_openFile(context);
  }


Future<void> _openFile(BuildContext context) async {
    try {
      String mimeType = lookupMimeType(widget.filePath) ?? 'application/octet-stream';
      if (await canLaunch(widget.filePath)) {
        await launch(widget.filePath);

      } else {
        // If the URL cannot be launched, try using the open_file package
        await OpenFile.open(widget.filePath, type: mimeType);
      }
    } catch (e) {
      print('Error opening file: $e');
      // Handle the error, show a snackbar, or display an error message to the user
    }
  }
}
