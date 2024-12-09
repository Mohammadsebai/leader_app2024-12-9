import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class CallPage extends StatefulWidget {
  const CallPage({
    Key? key,
    required this.conferenceID,
    required this.userID,
    required this.userName,
    required this.turnOnCameraWhenJoining,
    required this.turnOnMicrophoneWhenJoining,
    required this.imageuser,
  }) : super(key: key);

  final String conferenceID;
  final String userID;
  final String userName;
  final String imageuser;
  final bool turnOnCameraWhenJoining;
  final bool turnOnMicrophoneWhenJoining;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> _removeNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

 @override
  void dispose() {
    // Remove notification when call ends
    _removeNotification();
    super.dispose();
  }
@override
  void initState() {
    super.initState();
    // Show notification when call starts
    _showNotification('ID:${widget.conferenceID}', 'You are in a call');
        _startBackgroundTask();

  }



  Future<void> _startBackgroundTask() async {
  // Configure the background task
  await FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: (service) => onStart ,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: (service) => onStart ,
      onBackground: onIosBackground,
    ),
  );

  // Start executing the background task
   FlutterBackgroundService().invoke("start");

}

  void onStart() {
    // Implement any background task logic here
    // For example, you can keep the app alive in the background

     Timer.periodic(const Duration(seconds: 30), (timer) {
    // This is your heartbeat signal
    print('App is alive');
  });
  }

  Future<bool> onIosBackground(ServiceInstance service) async {
  // Implement any background task logic here
  // For example, you can keep the app alive in the background
  return true;
}
  @override
  Widget build(BuildContext context) {
    // Initialize flutter_local_notifications plugin
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
     //  iOS: IOSInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    List<IconData> customIcons = [
      Icons.note_add_rounded,
      Icons.group_add_rounded,
    ];

    if (widget.conferenceID.length < 8) {
      return AlertDialog(
        backgroundColor: Colors.blue[900]!.withOpacity(0.9),
        title: const Text("Error", style: TextStyle(color: Colors.white70)),
        content: const Text(" ID incorrect",
            style: TextStyle(color: Colors.white70)),
        actions: [
          ElevatedButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1204113231,
        appSign:
            "0e3fa976e3d6e76b1ad13a09c572a92be59e1f73f154442e0812f6a760d4c634",
        userID: widget.userID,
        userName: widget.userName,
        conferenceID: widget.conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(

           onLeaveConfirmation: (BuildContext context) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                  title: const Text("This is your custom dialog",
                      style: TextStyle(color: Colors.white70)),
                  content: const Text(
                      "You can customize this dialog however you like",
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    ElevatedButton(
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white70)),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                        child: const Text("Exit"),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
                  ],
                );
              },
            );
          },
          bottomMenuBarConfig: ZegoBottomMenuBarConfig(
            maxCount: 6,
            extendButtons: [
              for (int i = 0; i < customIcons.length; i++)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(60, 60),
                    backgroundColor: const Color(0xff2C2F3E).withOpacity(0.6),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {},
                  child: Icon(customIcons[i]),
                ),
            ],
            buttons: [
              ZegoMenuBarButtonName.toggleCameraButton,
              ZegoMenuBarButtonName.toggleMicrophoneButton,
              ZegoMenuBarButtonName.switchAudioOutputButton,
              ZegoMenuBarButtonName.leaveButton,
              ZegoMenuBarButtonName.switchCameraButton,
            ],
          ),
          turnOnCameraWhenJoining: widget.turnOnCameraWhenJoining,
          turnOnMicrophoneWhenJoining: widget.turnOnMicrophoneWhenJoining,
          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user,
              Map extraInfo) {
            return user != null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/newlife2001-49c6c.appspot.com/o/users%2FImages%2FProfile%2F${user.id}?alt=media&token=824a7a84-11fd-4c03-b92b-b34eb01dafbe',
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
          
        ),
      ),
    );
  }
}
