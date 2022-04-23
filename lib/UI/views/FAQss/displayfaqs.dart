import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:video_player/video_player.dart';

class DisplayFaq extends StatefulWidget {
  DisplayFaq({Key? key, required this.docid, required this.title})
      : super(key: key);
  final String docid;
  final String title;
  @override
  _DisplayFaqState createState() => _DisplayFaqState();
}

class _DisplayFaqState extends State<DisplayFaq> {
  List<Widget> widgetsss = [];
  // getitems(int index, int length, QueryDocumentSnapshot doc) {
  //   int i = index;
  //   List<Widget> widget = [];
  //   while (i <= length) {
  //     if (doc.data().toString().contains('text${i}')) {
  //       widget.add(Text(doc["text${i}"]));
  //     } else if (doc.data().toString().contains('image${i}')) {
  //       widget.add(Text(
  //         doc["image$i"],
  //         style: TextStyle(color: Colors.blue),
  //       ));
  //     } else {
  //       widget.add(Text(
  //         doc["video$i"],
  //         style: TextStyle(color: Colors.red),
  //       ));
  //     }
  //     i++;
  //   }
  //   return widget;
  // }
  int length = 0;

  fetchitems() async {
    List<Widget> widgets = [];
    String res = "Data Fetched";

    DocumentReference dbRef =
        FirebaseFirestore.instance.collection('FAQs').doc(widget.docid);

    await dbRef.get().then((doc) {
      int count = doc["count"];
      setState(() {
        length = count;
      });
      print(length);
      int i = 1;
      while (i <= count) {
        if (doc.data().toString().contains('text${i}')) {
          setState(() {
            widgets.add(Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                doc["text${i}"],
                style: TextStyle(
                    color: Colors.white, fontFamily: "Poppins", fontSize: 18),
              ),
            ));
          });

          // print("text");
          i++;
          // print(widgets);
          continue;
        } else if (doc.data().toString().contains('image${i}')) {
          setState(() {
            widgets.add(Image.network(
              doc["image$i"],
              width: 700,
              height: 500,
            ));
          });

          i++;
          // print(widgets);
          continue;
        } else if (doc.data().toString().contains('video${i}')) {
          setState(() {
            widgets.add(
              VideoWidget(
                url: doc["video$i"],
              ),
            );
          });

          // print(widgets);
          i++;
        } else {
          setState(() {
            widgets.add(Container());
          });
          i++;
        }

        // i++;
      }
    });
//     WidgetsBinding.instance1.addPostFrameCallback((_){

//   // Add Your Code here.

// });
    setState(() {
      widgetsss = widgets;
    });
    print(widgetsss);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchitems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: backGround_color,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(""),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgetsss,
                ),
              ],
            ),
          ),
        ));
  }
}

class VideoWidget extends StatefulWidget {
  VideoWidget({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(true);
    _controller!.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      width: Responsive.isDesktop(context) ? width * 0.4 : width * 0.6,
      height: height * 0.8,
      child: Stack(children: [
        FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(_controller!);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                );
              }
            }),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 35,
                color: backGround_color,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
