import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_connect/bottomNavBar.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Logs',
          style: TextStyle(color: Colors.white, fontFamily: 'gilroy'),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => bottomNavigationBar()));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
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
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white)),
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
              child:
                  Text('No logs found.', style: TextStyle(color: Colors.white)),
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
                          backgroundColor: Colors.black,
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
                    color: Colors.white,
                  ),
                );
              } else {
                mediaWidget = SizedBox.shrink();
              }

              return ListTile(
                title:
                    Text('Type: $type', style: TextStyle(color: Colors.white)),
                subtitle: Text('Address: $address',
                    style: TextStyle(color: Colors.grey)),
                leading: mediaWidget,
                tileColor: Colors.black,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: VideoPlayer(_controller),
            ),
          ),
          if (!_isPlaying)
            const Icon(
              Icons.play_circle_filled,
              size: 50,
              color: Colors.white,
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
          backgroundColor: Colors.black,
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
                    color: Colors.white,
                  ),
                if (_controller.value.isPlaying || _isPlaying)
                  Center(
                    child: IconButton(
                      icon: _isPlaying
                          ? Icon(Icons.pause, color: Colors.white)
                          : Icon(Icons.play_arrow, color: Colors.white),
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
