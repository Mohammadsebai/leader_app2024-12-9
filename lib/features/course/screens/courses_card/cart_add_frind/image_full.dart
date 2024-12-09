import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;

class ImageFullScreenScreen extends StatefulWidget {
  final String imageUrl;

  const ImageFullScreenScreen( {Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageFullScreenScreen> createState() => _ImageFullScreenScreenState();
}

class _ImageFullScreenScreenState extends State<ImageFullScreenScreen> {
  Future<void> _saveImageToGallery() async {
    try {
      final http.Response response = await http.get(Uri.parse(widget.imageUrl));
      final Uint8List bytes = response.bodyBytes;

      //await ImageGallerySaver.saveImage(bytes);
      
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text(
      'تم الحفظ',
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 3),
  ),
);


    } catch (e) {
      // Handle exceptions, if any
      print('Failed to save image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _saveImageToGallery,
          ),
        ],
      ),
      body: GestureDetector(
        
        onTap: () {
          Navigator.pop(context); // Close the fullscreen image on tap
        },
        child: Container(
          color: Colors.black,
          child: Center(
            
            child: Hero(
              tag: widget.imageUrl,
              child: Image.network(
                widget.imageUrl,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
