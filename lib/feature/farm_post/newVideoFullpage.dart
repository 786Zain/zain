import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerNew extends StatefulWidget {
  final String filePaths;
  VideoPlayerNew({Key key, @required this.filePaths}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => new _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<VideoPlayerNew> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _future;

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {
      print(_videoPlayerController.value.aspectRatio);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        autoPlay: true,
        looping: false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.filePaths);
    _future = initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            return Center(
              child: _videoPlayerController.value.initialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Chewie(
                  controller: _chewieController,
                ),
              )
                  : CircularProgressIndicator(backgroundColor: Colors.blue,),
            );
          }
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}