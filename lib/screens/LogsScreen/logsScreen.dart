import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentUserMobileNumber(),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('User not authenticated.'),
          );
        }
        return LogScreenBody(mobileNumber: snapshot.data!);
      },
    );
  }

  Future<String?> _getCurrentUserMobileNumber() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.phoneNumber;
    }
    return null;
  }
}

class LogScreenBody extends StatelessWidget {
  final String mobileNumber;

  const LogScreenBody({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(mobileNumber)
            .collection('logs')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(
              child: Text('No logs found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var log =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>?;

              if (log == null) {
                return const SizedBox.shrink();
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
              } else if (type == 'audio' &&
                  mediaUrl != null &&
                  mediaUrl.isNotEmpty) {
                mediaWidget = GestureDetector(
                  onTap: () {
                    // Add functionality to play audio if needed
                  },
                  child: Icon(
                    Icons.mic,
                    size: 50,
                    color: Colors.black,
                  ),
                );
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
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(_videoListener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openVideoDialog(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: VideoPlayer(_controller),
          ),
          if (!_isPlaying)
            const Icon(
              Icons.play_circle_filled,
              size: 50,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  void _openVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => _togglePlayPause(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: VideoPlayer(_controller),
                ),
                if (!_controller.value.isPlaying && !_isPlaying)
                  const Icon(
                    Icons.play_circle_filled,
                    size: 50,
                    color: Colors.black,
                  ),
                if (_controller.value.isPlaying || _isPlaying)
                  Center(
                    child: IconButton(
                      icon: _isPlaying
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        if (_isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _videoListener() {
    if (_controller.value.isPlaying && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    } else if (!_controller.value.isPlaying && _isPlaying) {
      setState(() {
        _isPlaying = false;
      });
    }
  }
}
