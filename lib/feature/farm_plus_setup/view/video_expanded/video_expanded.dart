import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_setup/repo/farm_plus_repo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class VideoExpandedPage extends ConsumerWidget {
  final categoryName;
  final bodyText;
  final imageurl;
  final title;
  final filepath;

  VideoExpandedPage({this.categoryName,this.bodyText,this.imageurl,this.title,this.filepath});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final FarmPlusRepo = watch(farmPlusProvider);
    print('filepath');
    print(filepath);
    return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Container(
                // padding: EdgeInsets.only(left: 80),
                child: Text(
                  '$categoryName',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  child: Text('$title',
                    style:TextStyle(color: Colors.grey,fontSize: 18),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 200,
                  width: 400,
                  child: VideoPlayerNeww(
                       filePaths: filepath,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(top: 35,left: 10,right: 10),
                  child: Text(
                    '$bodyText',
                    textAlign: TextAlign.justify,style: TextStyle(color: Colors.grey,fontSize: 18),
                  ),
                )
              ],
            ),
          );

  }
}



// class VideoWidget extends StatefulWidget {
//   final String url;
//   final bool play;
//
//   const VideoWidget({Key key, @required this.url, @required this.play})
//       : super(key: key);
//   @override
//   _VideoWidgetState createState() => _VideoWidgetState();
// }
//
// class _VideoWidgetState extends State<VideoWidget> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     print("widget url");
//     print(widget.url);
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url);
//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//       setState(() {});
//     });
//
//     if (widget.play) {
//       _controller.play();
//       // _controller.setLooping(true);
//     }
//   }
//
//   @override
//   void didUpdateWidget(VideoWidget oldWidget) {
//     if (oldWidget.play != widget.play) {
//       if (widget.play) {
//         _controller.play();
//         _controller.setLooping(true);
//       } else {
//         _controller.pause();
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return GestureDetector(
//               child: widget.url == null ?
//               Container(
//                   color: Colors.black,
//                   child: Center(
//                     child: Text(
//                       'No Video in the particular post',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white),
//                     ),
//                   )
//               )
//                       :
//               Stack(
//                 children: [
//                   VideoPlayer(_controller),
//                   Container(
//                     alignment: Alignment.center,
//                     child: ClipOval(
//                       child: Material(
//                         color: Colors.blue, // button color
//                         child: SizedBox(
//                             width: 46,
//                             height: 46,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (_controller
//                                       .value.isPlaying) {
//                                     _controller.pause();
//                                   } else {
//                                     _controller.play();
//                                   }
//                                 });
//                               },
//                               child: Icon(
//                                 _controller.value.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ],
//               ));
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }

class VideoPlayerNeww extends StatefulWidget {
  final String filePaths;
  VideoPlayerNeww({Key key, @required this.filePaths}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => new _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<VideoPlayerNeww> {
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
    return FutureBuilder(
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
                  : new CircularProgressIndicator(),
            );
          }
      );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}