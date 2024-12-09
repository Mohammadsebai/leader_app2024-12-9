// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
class ChewieVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ChewieVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ChewieVideoPlayerState createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      looping: false,
      autoPlay: false,
      allowFullScreen: true,
      showControls: true,
      additionalOptions: (context) => [
        OptionItem(iconData: Icons.save_alt, onTap: saveVideo, title: 'save'),
      ],
    );
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  }

  Future<void> saveVideo() async {
  try {
     Navigator.pop(context);
 ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text(
      'جاري  الحفظ',
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 3),
  ),
);
  Random random = Random();
   double randomNumber = random.nextDouble();

    await _requestPermission();
    Dio dio = Dio();
    final response = await dio.get(
      widget.videoUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final appDocDir = await getExternalStorageDirectory();
    const directoryPath = '/storage/emulated/0/Movies/my_videos';
    final savePath = '$directoryPath/${randomNumber+DateTime.now().millisecondsSinceEpoch}.mp4';

    // Ensure the directory exists, create it if not
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    await File(savePath).writeAsBytes(response.data!);
   ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text(
      'تم الحفظ',
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 3),
  ),
);
  
  
  } catch (error) {
    print('Error saving video: $error');
  }
}


  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Chewie(controller: _chewieController),
        )
      ],
    );
  }
}
