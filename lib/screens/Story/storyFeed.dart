import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:safe_connect/bottomNavBar.dart';
import 'package:safe_connect/screens/Story/uploadStory.dart';

class StoryFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.to(() => bottomNavigationBar());
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Feed',
          style: TextStyle(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('story').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var story = snapshot.data!.docs[index];
              String imageUrl = story['imageUrl'];
              String name = story['name'];
              String comment = story['comment'];
              int rating = story['rating'];
              Timestamp timestamp = story['timestamp'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        timestamp.toDate().toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ), 
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 350.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UpvoteButton(), 
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$comment',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFB13D),
        onPressed: () {
          Get.to(() => StoryUploadPage());
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class UpvoteButton extends StatefulWidget {
  @override
  _UpvoteButtonState createState() => _UpvoteButtonState();
}

class _UpvoteButtonState extends State<UpvoteButton> {
  bool isUpvoted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isUpvoted = !isUpvoted;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10,top: 7),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), // Adjust border radius
            color: isUpvoted ? Color(0xFFFFB13D) : Colors.grey.withOpacity(0.3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Adjust main axis size
            children: [
              Icon(
                Icons.arrow_upward_rounded,
                color: isUpvoted ? Colors.black : Colors.white,
                size: 18, 
              ),
              SizedBox(width: 2), 
              Text(
                'Upvote',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 12.0, 
                  color: isUpvoted ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}