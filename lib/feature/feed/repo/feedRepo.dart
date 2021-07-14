import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FeedRepo extends ChangeNotifier {
  List<FeedDetail> feedList = [];
  Data feedDetail;
  int _notificationCount = 0;
  int get notificationCount => _notificationCount;
  List<String> postIdMapper = [];

  List<Comment> commentList = [];
  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  List<dynamic> likeCollectionComment = [];
  List<dynamic> likeCollectionCountComment = [];
  getFeedList() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getFeedList("Bearer $auth").then((value) {
      feedList = value.data;
      print('hjhhhhhhhhhhhhhhhhhh');
      print(notificationCount);
      _notificationCount = value.notificationCount;
      print(notificationCount);
      List<Comment> commentList = [];
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  setNotificationCount(count) {
    print('llllllllllllllllllllllllllllllllllll $count');
    print(_notificationCount);
    _notificationCount = count;
    notifyListeners();
  }

  setCounterEmpty() {
    _notificationCount = 0;
    notifyListeners();
  }

  getFeedUserInfo(postId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();

    _apiCall.userdetailsBasedOnId("Bearer $auth", postId).then((value) {
      feedDetail = value.data;
      commentList = value.data.comments;
      likeCollection = value.data.post[0].like;
      likeCollectionCount = value.data.post;
      likeCollectionComment = [];
      value.data.comments.forEach((element) {
        likeCollectionComment.add(element.like);
      });

      likeCollectionCountComment = value.data.comments;

      notifyListeners();
      return feedDetail;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
    //  notifyListeners();
    // return feedDetail;
  }

  repostFeedPost(String id, repost) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unRepost = repost.contains(userId);

    print('repost value check here');
    print(unRepost);

    _apiCall.repostFeedPost("Bearer $auth", id, !unRepost).then((value) async {
      feedList
        ..asMap().forEach((index, data) => {
              if (data.id == id)
                {
                  !unRepost
                      ? data.repost.add(userId)
                      : data.repost.remove(userId)
                }
            });
      await getFeedUserInfo(id);
      notifyListeners();
      return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }

  repostSubCommentPost(String id, repost) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unRepost = repost.contains(userId);

    _apiCall.repostSubCommentPost("Bearer $auth", id, !unRepost).then((value) {
      commentList
        ..asMap().forEach((index, data) => {
              if (data.id == id)
                {
                  !unRepost
                      ? data.repost.add(userId)
                      : data.repost.remove(userId)
                }
            });
      notifyListeners();
      return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }

  likeOrDislike(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;

    feedList.forEach((element) {
      if (element.id == postId) {
        if (element.like.contains(userId)) {
          unlike = true;
        } else {
          unlike = false;
        }
      }
    });

    print('Likeeeee');
    print(unlike);

    return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
      // getFeedList();
      getFeedUserInfo(postId);

      for (int i = 0; i <= feedList.length - 1; i++) {
        if (feedList[i].id == postId) {
          if (unlike == true) {
            feedList[i].like.remove(userId);
          } else {
            print('pppppp');
            print(userId);
            feedList[i].like.add(userId);
          }
        }
      }
      // if (data.message == "Posted user $postLikeArray  $unlike like") {
      //   Flushbar(
      //     // There is also a messageText property for when you want to
      //     // use a Text widget and not just a simple String
      //     message: 'Posted user cannot like',
      //     // Even the button can be styled to your heart's content
      //     mainButton: FlatButton(
      //       child: Text(
      //         'Click Me',
      //         style: TextStyle(color: Theme.of(context).accentColor),
      //       ),
      //       onPressed: () {},
      //     ),
      //     duration: Duration(seconds: 3),
      //     // Show it with a cascading operator
      //   )..show(context);
      //   // feedList
      //   //   ..asMap().forEach((index, data) => {
      //   //         print(index),
      //   //         print(data),
      //   //         if (data.id == postId)
      //   //           {!unlike ? data.like.add(userId) : data.like.remove(userId)}
      //   //       });
      // } else {
      //   Flushbar(
      //     // There is also a messageText property for when you want to
      //     // use a Text widget and not just a simple String
      //     message: '${data.message}  $postLikeArray   $unlike',
      //     // Even the button can be styled to your heart's content
      //     mainButton: FlatButton(
      //       child: Text(
      //         'Click Me',
      //         style: TextStyle(color: Theme.of(context).accentColor),
      //       ),
      //       onPressed: () {},
      //     ),
      //     duration: Duration(seconds: 3),
      //     // Show it with a cascading operator
      //   )..show(context);
      // }

      notifyListeners();
      return null;
    }).catchError((err) {
      // Flushbar(
      //   // There is also a messageText property for when you want to
      //   // use a Text widget and not just a simple String
      //   message: '${err.message}  $postLikeArray   $unlike',
      //   // Even the button can be styled to your heart's content
      //   mainButton: FlatButton(
      //     child: Text(
      //       'Click Me',
      //       style: TextStyle(color: Theme.of(context).accentColor),
      //     ),
      //     onPressed: () {},
      //   ),
      //   duration: Duration(seconds: 3),
      //   // Show it with a cascading operator
      // )..show(context);

      ErrorHandler.handleError(err);
    });
  }

  //For Comment
  likeOrDislikeComment(
      BuildContext context, commentId, commentsLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unlike;

    commentList.forEach((element) {
      if (element.id == commentId) {
        if (element.like.contains(userId)) {
          unlike = true;
        } else {
          unlike = false;
        }
      }
    });

    return _apiCall
        .likeOrDislikeComment("Bearer $auth", commentId, unlike)
        .then((data) {
      // getFeedList();
      // getFeedUserInfo(commentId);

      for (int i = 0; i <= commentList.length - 1; i++) {
        if (commentList[i].id == commentId) {
          if (unlike == true) {
            commentList[i].like.remove(userId);
          } else {
            commentList[i].like.add(userId);
          }
        }
      }

      notifyListeners();
      return null;
    }).catchError((err) {
      // Flushbar(
      //   // There is also a messageText property for when you want to
      //   // use a Text widget and not just a simple String
      //   message: '${err.message}  $postLikeArray   $unlike',
      //   // Even the button can be styled to your heart's content
      //   mainButton: FlatButton(
      //     child: Text(
      //       'Click Me',
      //       style: TextStyle(color: Theme.of(context).accentColor),
      //     ),
      //     onPressed: () {},
      //   ),
      //   duration: Duration(seconds: 3),
      //   // Show it with a cascading operator
      // )..show(context);

      ErrorHandler.handleError(err);
    });
  }
}
