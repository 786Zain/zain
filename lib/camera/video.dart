import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:farm_system/camera/camera_form_gallery_view.dart';
import 'package:farm_system/camera/play_record_video.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:path_provider/path_provider.dart';

class Video extends StatefulWidget {
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId, parentUserId, grandParentId;
  final String userId;
  final String userName;

  const Video({Key key, this.textTyped, this.id, this.subCategory, this.commentPostImage, this.profilePicUser,
    this.adminPicUser,this.userNamePost, this.postId, this.parentId, this.parentUserId, this.grandParentId, this.userId, this.userName
  }) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  File _image;
  String imageFile;

  CameraController controller;
  List<CameraDescription> cameras;
  bool cameraInit;
  String parentId;
  String parentUserId;
  String grandParentId;


  Future<void> initCamera() async {
    availableCameras().then((value) {
      cameras = value;
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          cameraInit = true;
        });
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    cameraInit = false;
    initCamera();

    print("coming inside for visdeooooooooooooooo");
    print(widget.parentId);
    print(widget.parentUserId);
    print(widget.grandParentId);


    parentId = widget.parentId;
    parentUserId = widget.parentUserId;
    grandParentId = widget.grandParentId;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    if (!cameraInit) {
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    }
    // CameraLensDirection direction;
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: [
          // Container(
          //   child:
          // ),
      Transform.scale(
       scale: controller.value.aspectRatio / deviceRatio,
       // scale: 1 / controller.value.aspectRatio,
        child: Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
      ),
          // CameraPreview(controller),
          // Container(
          //   width: 400,
          // child: SvgPicture.asset(
          //     grids,
          // ),
          // ),

          Positioned(
            bottom: 35,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () => {AppNavigator.pop()},
                          child: Container(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Icon(
                      //   Icons.keyboard_arrow_up,
                      //   color: Colors.white,
                      //   size: 42,
                      // ),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.white,
                      // ),
                      //  Icon(getCameraLensIcon(direction))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 1.4),
                  RecordButton(
                    controller: controller,
                    textTyped: widget.textTyped,
                    id: widget.id,
                    subCategory: widget.subCategory,
                    commentPostImage: widget.commentPostImage,
                    profilePicUser: widget.profilePicUser,
                    adminPicUser: widget.adminPicUser,
                    userNamePost: widget.userNamePost,
                    postId: widget.postId,
                      parentId: parentId,
                      parentUserId: parentUserId,
                      grandParentId: grandParentId,
                    userId: widget.userId,
                      userName:widget.userName
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecordButton extends StatefulWidget {
  final CameraController controller;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId, parentUserId, grandParentId;
  final String userId;
  final String userName;

  RecordButton({@required this.controller, this.textTyped, this.id, this.subCategory, this.commentPostImage, this.profilePicUser,
  this.adminPicUser, this.userNamePost, this.postId, this.parentId, this.parentUserId, this.grandParentId,this.userId, this.userName
  });
  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  String videoPath;
  // Timer timer;
  bool isVideoRecording = false;
  bool slideVideo = true;
  bool portraits;

  String userId;
  String parentId;
  String parentUserId;
  String grandParentId;

  @override
  void initState() {
    super.initState();


    print("Updateddd");
    print(widget.commentPostImage);

    // print("coming inside button video");
    // print(widget.parentId);
    // print(widget.parentUserId);
    // print(widget.grandParentId);

    parentId = widget.parentId;
    parentUserId = widget.parentUserId;
    grandParentId = widget.grandParentId;


  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) print('Saving video to $filePath');
    });
  }

  Future<String> startVideoRecording() async {
    if (!widget.controller.value.isInitialized) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (widget.controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      setState(() {
        videoPath = filePath;
      });
      await widget.controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {

    if (!widget.controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await widget.controller.stopVideoRecording();
      playVideo(portraits);
    } on CameraException catch (e) {
      return null;
    }
  }

  void playVideo(bool portraits) {

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => PlayRecordedVideo(
          path: videoPath,
          portraits: portraits,
          textTyped: widget.textTyped,
          id: widget.id,
          subCategory: widget.subCategory,
            commentPostImage: widget.commentPostImage,
            profilePicUser: widget.profilePicUser,
            adminPicUser: widget.adminPicUser,
            userNamePost: widget.userNamePost,
            postId: widget.postId,
            parentId: parentId,
            parentUserId: parentUserId,
            grandParentId: grandParentId
        ),
      ),
    );
  }

  // Future<void> _initializeControllerFuture;

  @override
  Widget build(BuildContext context) {
    //WidgetsFlutterBinding.ensureInitialized();
    // final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    //  final firstCamera = cameras.first;

    bool useSensor = true;

    bool portrait;


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GestureDetector(
        //   onTap: () async => {_imgFromGallery()},
        //   child: Container(
        //     child: SvgPicture.asset(
        //       gallery,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        //   SizedBox(width: 40),
        isVideoRecording ? Container() : GestureDetector(
          onTap: () async => {
           //  takePic(),
            setState(() {
              slideVideo = true;
            })
          },
          child: slideVideo ?  NativeDeviceOrientationReader(
            builder: (context) {
              NativeDeviceOrientation orientation = NativeDeviceOrientationReader.orientation(context);
              if(orientation == NativeDeviceOrientation.portraitUp ){
                portrait = true;
              }else{
                portrait = false;
              }
              print("Received new orientation: $orientation");
              return Padding(
                padding: EdgeInsets.only(left: 40),
                child: GestureDetector(
                  onTap: () async =>{
                    print(widget.commentPostImage),
                    print("comment in video"),
                    takePic(portrait),
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor("D41B47"),
                    ),
                    child: Center(
                        child: SvgPicture.asset(
                          camera,
                          color: Colors.white,
                        )),
                  ),
                ),
              );
            },
            useSensor: useSensor,
          ) : Container(
            padding: EdgeInsets.all(20),
            child: Center(
                child: SvgPicture.asset(
                  camera,
                  color: Colors.white,
                )),
          ) ,
        ),
        // SizedBox(width: 40),
//        GestureDetector(
//          onTap: () async => {_imgFromGallery()},
//          child: Container(
//            child: SvgPicture.asset(
//              video,
//              color: Colors.white,
//            ),
//          ),
//        ),
      Padding(
          padding: EdgeInsets.only(right: 25)
      ),

    //For Hiding the video in Comment Post and Sub Comment Post

   widget.commentPostImage == 'Post Update' ? Container():
   widget.commentPostImage == 'Comment Post' ? Container() :
   widget.commentPostImage == 'Comment Reply' ? Container()
       : GestureDetector(
     onTap: () {
       setState(() {
         slideVideo = false;
       });
       // if (!isVideoRecording) {
       //   startVideoRecording();
       //   setState(() {
       //     isVideoRecording = true;
       //   });
       // } else {
       //   stopVideoRecording();
       //   setState(() {
       //     isVideoRecording = false;
       //   });
       //   playVideo();
       // }
     },
     child: isVideoRecording ?  GestureDetector(
       onTap: () {
         stopVideoRecording();
         playVideo(portraits);
       },
       child: Container(
         width: 150,
         padding: EdgeInsets.all(15),
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: Colors.white,
         ),
         child: Icon(
           Icons.stop,
           color: HexColor("D41B47"),
           size: 40,
         ),
       ),
     ): NativeDeviceOrientationReader(
       builder: (context){
         NativeDeviceOrientation orientation = NativeDeviceOrientationReader.orientation(context);
         if(orientation == NativeDeviceOrientation.portraitUp ){
           print("true");
           portraits = true;
         }else{
           print("false");
           portraits = false;
         }
         print("Received new orientation: $orientation");
         return  widget.userId ==null ? Container(
           // child:
           // !isVideoRecording
           //     ? SvgPicture.asset(
           //         video,
           //         color: Colors.white,
           //       )
           //     : Icon(Icons.stop, color: Colors.white, size: 28),
             child: slideVideo ? SvgPicture.asset(
               video,
               color: Colors.white,
             ) :
             Padding(
               padding: EdgeInsets.only(right: 60),
               child: GestureDetector(
                 onTap: () {
                   print("kbshf");
                   if (!isVideoRecording) {
                     startVideoRecording();
                     setState(() {
                       isVideoRecording = true;
                     });
                   } else {
                     stopVideoRecording();
                     setState(() {
                       isVideoRecording = false;
                     });


                     // playVideo(portraits);

                   }
                 },
                 child: Container(
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: HexColor("D41B47"),
                   ),
                   child: Center(
                       child: SvgPicture.asset(
                         video,
                         color: Colors.white,
                       )),
                 ),
               ),
             )
         ): Container();
       },
       useSensor: useSensor,
     ) ,

   ),

      ],
    );
  }


  takePic(bool portrait) async {

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    await widget.controller.takePicture(filePath);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DisplayPictureScreen1(
                imagePath: File(filePath),
                portrait : portrait,
                textTyped: widget.textTyped,
              commentPostImage: widget.commentPostImage,
            profilePicUser: widget.profilePicUser,
            adminPicUser: widget.adminPicUser,
            userNamePost: widget.userNamePost,
              postId: widget.postId,
                parentId: parentId,
                parentUserId: parentUserId,
                grandParentId: grandParentId,
                userId:widget.userId,
                userName:widget.userName
                // Pass the appropriate camera to the TakePictureScreen widget.
              )),
    );
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    File _image;
    setState(() {
      _image = image;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen1(imagePath: _image),
      ),
    );
  }
}

class RecordButtonPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  RecordButtonPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 9390);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//import 'dart:async';
//import 'dart:io';
//import 'dart:math';
//import 'dart:ui';
//
//import 'package:camera/camera.dart';
//import 'package:farm_system/camera/camera_form_gallery_view.dart';
//import 'package:farm_system/camera/play_record_video.dart';
//import 'package:farm_system/constant/constants.dart';
//import 'package:farm_system/navigator.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:hexcolor/hexcolor.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
//
//class Video extends StatefulWidget {
//  @override
//  _VideoState createState() => _VideoState();
//}
//
//class _VideoState extends State<Video> {
//  IconData getCameraLensIcon(CameraLensDirection direction) {
//    switch (direction) {
//      case CameraLensDirection.back:
//        return Icons.camera_rear;
//      case CameraLensDirection.front:
//        return Icons.camera_front;
//      case CameraLensDirection.external:
//        return Icons.camera;
//    }
//    throw ArgumentError('Unknown lens direction');
//  }
//
//  File _image;
//  String imageFile;
//
//  CameraController controller;
//  List<CameraDescription> cameras;
//  bool cameraInit;
//  Future<void> initCamera() async {
//    availableCameras().then((value) {
//      cameras = value;
//      controller = CameraController(cameras[0], ResolutionPreset.medium);
//      controller.initialize().then((_) {
//        if (!mounted) {
//          return;
//        }
//        setState(() {
//          cameraInit = true;
//        });
//      });
//    }).catchError((onError) {
//      print(onError);
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    cameraInit = false;
//    initCamera();
//  }
//
//  @override
//  void dispose() {
//    controller?.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (!cameraInit) {
//      return Container(
//        color: Colors.black,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [CircularProgressIndicator()],
//        ),
//      );
//    }
//    // CameraLensDirection direction;
//    return AspectRatio(
//      aspectRatio: controller.value.aspectRatio,
//      child: Stack(
//        children: [
//          CameraPreview(controller),
//          Positioned(
//            bottom: 35,
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: [
//                      GestureDetector(
//                        onTap: () => {AppNavigator.pop()},
//                        child: Container(
//                          child: Icon(
//                            Icons.cancel,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      Icon(
//                        Icons.keyboard_arrow_up,
//                        color: Colors.white,
//                        size: 42,
//                      ),
//                      Icon(
//                        Icons.arrow_forward_ios,
//                        color: Colors.white,
//                      ),
//                      //  Icon(getCameraLensIcon(direction))
//                    ],
//                  ),
//                  SizedBox(height: MediaQuery.of(context).size.height / 1.4),
//                  RecordButton(
//                    controller: controller,
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class RecordButton extends StatefulWidget {
//  final CameraController controller;
//  RecordButton({@required this.controller});
//  @override
//  _RecordButtonState createState() => _RecordButtonState();
//}
//
//class _RecordButtonState extends State<RecordButton>
//    with TickerProviderStateMixin {
//  double percentage = 0.0;
//  double newPercentage = 0.0;
//  double videoTime = 0.0;
//  String videoPath;
// // Timer timer;
//  AnimationController percentageAnimationController;
//  bool isVideoRecording = false;
//
//  @override
//  void initState() {
//    super.initState();
//    setState(() {
//      percentage = 0.0;
//    });
//    percentageAnimationController = new AnimationController(
//        vsync: this, duration: new Duration(milliseconds: 1000))
//      ..addListener(() {
//        setState(() {
//          percentage = lerpDouble(
//              percentage, newPercentage, percentageAnimationController.value);
//        });
//      });
//  }
//
//  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
//
//  void onVideoRecordButtonPressed() {
//    startVideoRecording().then((String filePath) {
//      if (mounted) setState(() {});
//      if (filePath != null) print('Saving video to $filePath');
//    });
//  }
//
//  Future<String> startVideoRecording() async {
//    if (!widget.controller.value.isInitialized) {
//      return null;
//    }
//
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Movies/flutter_test';
//    await Directory(dirPath).create(recursive: true);
//    final String filePath = '$dirPath/${timestamp()}.mp4';
//
//    if (widget.controller.value.isRecordingVideo) {
//      // A recording is already started, do nothing.
//      return null;
//    }
//
//    try {
//      setState(() {
//        videoPath = filePath;
//      });
//      await widget.controller.startVideoRecording(filePath);
//    } on CameraException catch (e) {
//      return null;
//    }
//    return filePath;
//  }
//
//  Future<void> stopVideoRecording() async {
//    if (!widget.controller.value.isRecordingVideo) {
//      return null;
//    }
//
//    try {
//      await widget.controller.stopVideoRecording();
//    } on CameraException catch (e) {
//      return null;
//    }
//  }
//
//  void playVideo() {
//    Navigator.push(
//      context,
//      CupertinoPageRoute(
//        builder: (_) => PlayRecordedVideo(
//          path: videoPath,
//        ),
//      ),
//    );
//  }
//
//  // Future<void> _initializeControllerFuture;
//
//  @override
//  Widget build(BuildContext context) {
//    //WidgetsFlutterBinding.ensureInitialized();
//    // final cameras = await availableCameras();
//
//    // Get a specific camera from the list of available cameras.
//    //  final firstCamera = cameras.first;
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: [
//        GestureDetector(
//          onTap: () async => {_imgFromGallery()},
//          child: Container(
//            child: SvgPicture.asset(
//              gallery,
//              color: Colors.white,
//            ),
//          ),
//        ),
//        //   SizedBox(width: 40),
//        GestureDetector(
//          onTap: () async => {takePic()},
//          child: Container(
//            padding: EdgeInsets.all(20),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: HexColor("D41B47"),
//            ),
//            child: Center(
//                child: SvgPicture.asset(
//              camera,
//              color: Colors.white,
//            )),
//          ),
//        ),
//        // SizedBox(width: 40),
////        GestureDetector(
////          onTap: () async => {_imgFromGallery()},
////          child: Container(
////            child: SvgPicture.asset(
////              video,
////              color: Colors.white,
////            ),
////          ),
////        ),
//        GestureDetector(
//          onTap: () {
//            if (!isVideoRecording) {
//              startVideoRecording();
//              setState(() {
//                isVideoRecording = true;
//              });
//            } else {
//              stopVideoRecording();
//              setState(() {
//                percentage = newPercentage;
//                newPercentage += 1;
//                if (newPercentage > 9390.0) {
//                  percentage = 0.0;
//                  newPercentage = 0.0;
//                  // timer.cancel();
//
//                }
//                isVideoRecording = false;
//                percentageAnimationController.forward(from: 0.0);
//              });
//              playVideo();
//
////              timer = new Timer.periodic(
////                Duration(milliseconds: 1),
////                (Timer t) => setState(() {
////                  percentage = newPercentage;
////                  newPercentage += 1;
////                  if (newPercentage > 9390.0) {
////                    percentage = 0.0;
////                    newPercentage = 0.0;
////                    timer.cancel();
////                    stopVideoRecording();
////                    playVideo();
////                  }
////                  isVideoRecording = false;
////                  percentageAnimationController.forward(from: 0.0);
////                  // print((t.tick / 1000).toStringAsFixed(0));
////                }),
////              );
//            }
//          },
////          onLongPressEnd: (e) {
////            percentage = 0.0;
////            newPercentage = 0.0;
////            timer.cancel();
////            stopVideoRecording();
////            playVideo();
////          },
//          child: Container(
//            child: !isVideoRecording
//                ? SvgPicture.asset(
//                    video,
//                    color: Colors.white,
//                  )
//                : Icon(Icons.stop, color: Colors.white, size: 28),
//          ),
//        )
//      ],
//    );
//  }
//
//  takePic() async {
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Pictures/flutter_test';
//    await Directory(dirPath).create(recursive: true);
//    final String filePath = '$dirPath/${timestamp()}.jpg';
//    await widget.controller.takePicture(filePath);
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) => DisplayPictureScreen1(
//                imagePath: File(filePath),
//                // Pass the appropriate camera to the TakePictureScreen widget.
//              )),
//    );
//  }
//
//  _imgFromGallery() async {
//    File image = await ImagePicker.pickImage(
//        source: ImageSource.gallery, imageQuality: 50);
//    File _image;
//    setState(() {
//      _image = image;
//    });
//    print('here is the image path $_image');
//    Navigator.of(context).pop();
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => DisplayPictureScreen1(imagePath: _image),
//      ),
//    );
//
//    // Navigator.push(context, MaterialPageRoute(builder: (context) {
//    //   var displayPictureScreen = DisplayPictureScreen;
//    //   return displayPictureScreen();
//    // }));
//  }
//}
//
//class RecordButtonPainter extends CustomPainter {
//  Color lineColor;
//  Color completeColor;
//  double completePercent;
//  double width;
//  RecordButtonPainter(
//      {this.lineColor, this.completeColor, this.completePercent, this.width});
//  @override
//  void paint(Canvas canvas, Size size) {
//    Paint line = new Paint()
//      ..color = lineColor
//      ..strokeCap = StrokeCap.round
//      ..style = PaintingStyle.stroke
//      ..strokeWidth = width;
//    Paint complete = new Paint()
//      ..color = completeColor
//      ..strokeCap = StrokeCap.round
//      ..style = PaintingStyle.stroke
//      ..strokeWidth = width;
//    Offset center = new Offset(size.width / 2, size.height / 2);
//    double radius = min(size.width / 2, size.height / 2);
//    canvas.drawCircle(center, radius, line);
//    double arcAngle = 2 * pi * (completePercent / 9390);
//    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
//        arcAngle, false, complete);
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return true;
//  }
//}
