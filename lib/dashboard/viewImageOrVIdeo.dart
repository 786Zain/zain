import 'package:analyzer/file_system/file_system.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class ViewImageOrVideo extends StatefulWidget {
  final String id;

  const ViewImageOrVideo({Key key, this.id}) : super(key: key);

  @override
  _ViewImageOrVideoState createState() => _ViewImageOrVideoState();
}

class _ViewImageOrVideoState extends State<ViewImageOrVideo> {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;
  void getVideoFile(fileUrl) async {
    try {
      final VideoPlayerController vcontroller =
          VideoPlayerController.network(fileUrl);
      videoPlayerListener = () {
        if (_controller != null && _controller.value.size != null) {
          if (mounted) setState(() {});
          _controller.removeListener(videoPlayerListener);
        }
      };
      vcontroller.addListener(videoPlayerListener);
      await vcontroller.setLooping(false);
      await vcontroller.initialize();
      //await _controller?.dispose();
      if (mounted) {
        setState(() {
          _controller = vcontroller;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _asyncLoader = Consumer(builder: (context, watch, child) {
      final feedProviderRepo = watch(feedProvider);
      return AsyncLoader(
          key: _asyncKey,
          initState: () => feedProviderRepo.getFeedUserInfo(widget.id),
          renderLoad: () => SizedBox(),
          renderError: ([err]) => Center(
                child: Text("Error"),
              ),
          renderSuccess: ({data}) => _generateView(data));
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
            height: 99, child: Center(child: SvgPicture.asset(logo_text_left))),
        centerTitle: true,
        leading: GestureDetector(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.deepOrange,
                ),
                onPressed: null),
            onTap: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_asyncLoader],
        ),
      ),
    );
  }

  _generateView(PostDetailsBasedOnId data) {

    // int index;
    // print(list);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            // ListTile(
            //   leading: Container(
            //     margin: EdgeInsets.only(top: 10),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //       child: CachedNetworkImage(
            //           fit: BoxFit.fill,
            //           height: 25,
            //           width: 25,
            //           imageUrl:  data.data.profilePic[0]
            //       ),
            //     ),
            //   ),
            //   title: Container(
            //     margin: EdgeInsets.only(top: 16),
            //     child: Text("@abc_123",
            //         style: TextStyle(
            //           fontSize: 15,
            //         )),
            //   ),
            //   // trailing: Container(
            //   //     margin: EdgeInsets.only(right: 10),
            //   //     child: Text(getTime(data.data[index].createdAt),
            //   //         style: TextStyle(fontSize: 15))),
            // ),
            // Visibility(
            //   visible: data.data.caption.isNotEmpty,
            //   child: Container(
            //     alignment: Alignment.topLeft,
            //     padding:
            //     EdgeInsets.only(left: 29, right: 29, top: 09),
            //     child: Text(data.data.caption,
            //         style: TextStyle(
            //           fontSize: 15,
            //           letterSpacing: 0.5,
            //         )),
            //   ),
            // ),
            // data.data != null
            //     ? Container(
            //         height: 400,
            //         margin: EdgeInsets.only(top: 10),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.all(Radius.circular(0)),
            //           child: data.data.postPhoto[0].location.split('.').last !=
            //                   'mp4'
            //               ? CachedNetworkImage(
            //                   fit: BoxFit.fill,
            //                   height: 176,
            //                   width: 400,
            //                   imageUrl: data.data.postPhoto[0].location,
            //                 )
            //               : _controller != null && _controller.value.initialized
            //                   ? VideoPlayer(_controller)
            //                   : Container(),
            //         ),
            //       )
            //     : Container(),
            // Container(
            //   margin: EdgeInsets.only(left: 02, right: 01, top: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           _getCommentWidget(Icons.person, "11k", 0)
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           _getCommentWidget(Icons.comment, "3k", 1)
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           _getCommentWidget(
            //               Icons.arrow_downward_rounded, "2k", 2)
            //         ],
            //       ),
            //       Spacer(),
            //       Row(
            //         children: [
            //           _getCommentWidget(Icons.bookmark_border, "", 2)
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 22),
            //   child: Divider(
            //     height: 1,
            //     thickness: 0.5,
            //     color: Colors.grey,
            //   ),
            // )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewImageOrVideo(
                      id: widget.id,
                    )));
      },
    );
  }

  _getCommentWidget(iconData, text1, i) {
    return GestureDetector(
      onTap: () => _handleOnTap(i),
      child: Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: i == 0 ? Colors.red : Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(left: 08, right: 15),
              child: Text(
                text1,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleOnTap(int i) {
    if (i == 0) {
      print("like");
    } else if (i == 1) {
      print("Comment");
    } else {
      print("Share");
    }
  }
}
