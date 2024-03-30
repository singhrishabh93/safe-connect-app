import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class HelpRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentUserPhoneNumber(),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text('User not authenticated.'),
          );
        }
        return LogScreenBody(phoneNumber: snapshot.data!);
      },
    );
  }

  Future<String?> _getCurrentUserPhoneNumber() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.phoneNumber;
    }
    return null;
  }
}

class LogScreenBody extends StatelessWidget {
  final String phoneNumber;

  const LogScreenBody({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .collection('logsForEmergencyContact')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text('No logs found for your emergency contact.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var log =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>?;

              if (log == null) {
                // Handle the case where log is null
                return SizedBox.shrink(); // or any other fallback widget
              }

              var mediaUrl = log['mediaLink'] as String?;
              var address = log['address'] as String?;
              var type = log['type'] as String?;

              Widget mediaWidget;

              if (type == 'image' && mediaUrl != null && mediaUrl.isNotEmpty) {
                mediaWidget = GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Image.network(
                            mediaUrl,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    );
                  },
                  child: Image.network(
                    mediaUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (type == 'video' &&
                  mediaUrl != null &&
                  mediaUrl.isNotEmpty) {
                mediaWidget = VideoWidget(videoUrl: mediaUrl);
              } else {
                mediaWidget = SizedBox.shrink();
              }

              return ListTile(
                title: Text('Type: $type'),
                subtitle: Text('Address: $address'),
                leading: mediaWidget,
              );
            },
          );
        },
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading video');
                  } else {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  }
                },
              ),
            );
          },
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // or set as per your video aspect ratio
            child: VideoPlayer(_controller),
          ),
          Icon(
            Icons.play_circle_filled,
            size: 50,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
