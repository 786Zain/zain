import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenView extends StatefulWidget {
  final File filePaths;

  const FullScreenView({
    Key key,
    this.filePaths,
  }) : super(key: key);
  @override
  _FullScreenViewState createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  var imageFileTypes = ["png", "jpg", "jpeg", "gif", "HEIC"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(Icons.close),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 15, right: 10),
            // child: Container(
            //   child:  Text("SAVE"),
            // ),
          )
        ],
      ),
      body: imageFileTypes.indexOf(widget.filePaths.path.split('.').last) != -1
          ? Center(
              child: Container(
                child: Image.file(widget.filePaths),
              ),
            )
          : Container(
              // height: 250,
              // width: 168,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: ChewieListItem(
                  videoPlayerController:
                      VideoPlayerController.file(widget.filePaths),
                ),
              ),
            ),
    );
  }
}

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      // aspectRatio: widget.videoPlayerController.value.aspectRatio,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      allowMuting: true,
      allowedScreenSleep: false,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: false,
      allowFullScreen: false,
      autoPlay: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController,
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: GestureDetector(
    //     // onTap: (){
    //     //   Navigator.of(context).push(SlideFromRight(widget: FullScreenView(
    //     //    filePath : widget.videoPlayerController,
    //     //   )));
    //     // },
    //     child: Container(
    //       child: Chewie(
    //         controller: _chewieController,
    //       ),
    //     ),
    //   ),
    // );
  }
  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
