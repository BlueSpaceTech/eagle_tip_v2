import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key, required this.videourl, required this.title})
      : super(key: key);
  final String videourl;
  final String title;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool isplaying = true;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.videourl,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller!.initialize();

    // Use the controller to loop the video.
    // _controller!.setLooping(true);
    _controller!.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: Container(
        height: height,
        color: backGround_color,
        width: width,
        child: Stack(children: [
          Positioned(
              left: 40,
              top: 40,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
          Positioned(
              left: width * 0.46,
              top: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 21),
                ),
              )),
          Center(
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: 11 / 5,
                      child: VideoPlayer(_controller!),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Positioned(
              left: width * 0.48,
              bottom: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(backGround_color),
                ),
                onPressed: () {
                  setState(() {
                    if (isplaying) {
                      _controller!.pause();
                      isplaying = false;
                    } else {
                      _controller!.play();
                      isplaying = true;
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isplaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.black,
                  ),
                ),
              )),
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: backGround_color,
      //   onPressed: () {
      //     setState(() {
      //       if (isplaying) {
      //         _controller!.pause();
      //         isplaying = false;
      //       } else {
      //         _controller!.play();
      //         isplaying = true;
      //       }
      //     });
      //   },
      //   child: Icon(
      //     isplaying ? Icons.pause : Icons.play_arrow,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
