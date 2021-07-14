import 'dart:async';

import 'package:analyzer/dart/ast/token.dart';
import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategory.model.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GlobalSearchPage extends StatefulWidget {
  @override
  _GlobalSearchPageState createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  TextEditingController _Controller = TextEditingController();
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  Timer _debounce;
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          getsearchWidget(context),

          Expanded(child: getfollowingWidget(context))
        ],
      ),
    );

    // return getfollowingWidget(context);
  }

  Widget getsearchWidget(context) {
    return Consumer(builder: (context, watch, child) {
      final addSearchproviders = watch(addSearchprovider);
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900,
        ),
        height: 30,
        //color: Colors.grey,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
        ),
        child: TextFormField(
          onChanged: (T) {
            if (_debounce?.isActive ?? false) _debounce.cancel();
            _debounce = Timer(const Duration(milliseconds: 800), () {
              setState(() {
                addSearchproviders.getSearchList(_Controller.text);
                addSearchproviders.searchList.clear();
              });
            });
          },
          controller: _Controller,
          showCursor: true,
          cursorColor: Colors.white,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(
              fontSize: 14.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: 'Search',
            contentPadding: EdgeInsets.only(bottom: 10, top: 4),
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    });
  }

  Widget getfollowingWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final addSearchproviders = watch(addSearchprovider);
        // final profileFollows = watch(profileFollow);
        return AsyncLoader(
          key: _asyncKey,
          // initState: () => addSearchproviders.getSearchList(""),
          initState: () => addSearchproviders.getSearchList(_Controller.text),
          renderLoad: () => Container(
            height: 0,
            width: 0,
            child: SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                    strokeWidth: 10)),
          ),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateFollowingUI(context),
        );
      }),
    );
  }

  _generateFollowingUI(context) {
    return Consumer(builder: (context, watch, child)
    {
      final addSearchproviders = watch(addSearchprovider);
      return
        addSearchproviders.searchList.isNotEmpty
            ?
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: ListView.builder(
              itemCount: addSearchproviders.searchList.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          addSearchproviders.searchList[i].profilePic != null ?
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    addSearchproviders
                                        .searchList[i].profilePic),
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0)),
                            ),
                          ) :
                          Container(
                            child: Image.asset(dummyUser,
                                fit: BoxFit.fill, height: 52, width: 52),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: addSearchproviders
                                      .searchList[i]
                                      .name !=
                                      null
                                      ?
                                  Text(
                                    addSearchproviders
                                        .searchList[i]
                                        .name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                    ),
                                  )
                                      : Text(" "),
                                ),
                                Container(
                                  child: addSearchproviders
                                      .searchList[i].userName !=
                                      null
                                      ? Text(
                                    '@' +
                                        addSearchproviders
                                            .searchList[i]
                                            .userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                    ),
                                  )
                                      : Text(""),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: addSearchproviders
                                      .searchList[i].bio !=
                                      null
                                      ? Text(
                                        addSearchproviders
                                            .searchList[i]
                                            .bio,
                                    style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                  )
                                      : Text(""),
                                )

                              ],
                            ),

                          ),
                SizedBox(width: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(

                child:
                    addSearchproviders.searchList[i].isFollowing ==
                        true
                        ?
                    followingButton(
                      addSearchproviders.searchList[i].id,
                    ):
                        followerButton(
                        addSearchproviders.searchList[i].id)


                    )

                  ],
                )

                        ],
                      )
                    ],
                  ),
                );
              }),
        )
            : Container(
          margin: EdgeInsets.only(
            top: 0.0,
          ),
          child: Center(
            child: Text(
              'No Search History Found',
              style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600]
              ),
            ),
          ),
        );











          // ListView.builder(
          //   itemCount: addSearchproviders.searchList.length,
          //   itemBuilder: (BuildContext context, int i) {
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(right: 15, top: 15),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Expanded(
          //                 child: Padding(
          //                     padding: EdgeInsets.only(top: 10.0),
          //                     child: Row(
          //                       crossAxisAlignment:
          //                           CrossAxisAlignment.start,
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.start,
          //                       children: [
          //                         Padding(
          //                             padding: EdgeInsets.only(
          //                                 left: 30, right: 20),
          //                             child: CircleAvatar(
          //                               radius: 26.0,
          //                               backgroundImage: NetworkImage(
          //                                   getImageUrl(addSearchproviders
          //                                           .searchList[i]
          //                                           .profilePic) ??
          //                                       "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
          //                             )),
          //                         Expanded(
          //                           child: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Container(
          //                                 child: Padding(
          //                                   padding: EdgeInsets.only(
          //                                       top: 8, bottom: 2),
          //                                   child: addSearchproviders
          //                                           .searchList[i]
          //                                           .name
          //                                           .isNotEmpty
          //                                       ? Text(
          //                                           addSearchproviders
          //                                               .searchList[i]
          //                                               .name
          //                                               .toUpperCase(),
          //                                           overflow:
          //                                               TextOverflow.fade,
          //                                           softWrap: false,
          //                                           style: TextStyle(
          //                                               fontSize: 14,
          //                                               letterSpacing: 2,
          //                                               fontWeight:
          //                                                   FontWeight
          //                                                       .bold,
          //                                               color:
          //                                                   Colors.white))
          //                                       : Text(""),
          //                                 ),
          //                               ),
          //                               Container(
          //                                 child: Padding(
          //                                   padding: EdgeInsets.only(
          //                                       bottom: 2),
          //                                   child: addSearchproviders
          //                                           .searchList[i]
          //                                           .userName
          //                                           .isNotEmpty
          //                                       ? Text(
          //                                           '@' +
          //                                               addSearchproviders
          //                                                   .searchList[i]
          //                                                   .userName
          //                                                   .toLowerCase(),
          //                                           overflow:
          //                                               TextOverflow.fade,
          //                                           softWrap: false,
          //                                           style: TextStyle(
          //                                               fontSize: 14,
          //                                               letterSpacing: 1,
          //                                               color:
          //                                                   Colors.white))
          //                                       : Text(""),
          //                                 ),
          //                               ),
          //                               Container(
          //                                 child: Padding(
          //                                   padding: EdgeInsets.only(
          //                                       top: 8, bottom: 2),
          //                                   child: addSearchproviders
          //                                                   .searchList[i]
          //                                                   .bio !=
          //                                               null &&
          //                                           addSearchproviders
          //                                               .searchList[i]
          //                                               .bio
          //                                               .isNotEmpty
          //                                       ? ReadMoreText(
          //                                           addSearchproviders
          //                                                   .searchList[i]
          //                                                   .bio ??
          //                                               '',
          //                                           style: TextStyle(
          //                                               fontSize: 14,
          //                                               letterSpacing: 1,
          //                                               color:
          //                                                   Colors.white))
          //                                       : Text(""),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         )
          //                       ],
          //                     )),
          //               ),
          //               addSearchproviders.searchList[i].isFollowing ==
          //                       true
          //                   ? followingButton(
          //                       addSearchproviders.searchList[i].id,
          //                     )
          //                   : followerButton(
          //                       addSearchproviders.searchList[i].id,
          //                     )
          //             ],
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // )
          // : Container(
          //     child: Text(
          //       "No Following Users",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   );
    });
  }

  Widget followerButton(
    String id,
  ) {
     return Consumer(builder: (context, watch, child)
     {
       final profileRepo = watch(profileProvider);
       final followsRepo = watch(profileFollow);
       return Container(
         margin: EdgeInsets.only(top: 10),
         width: 85,
         height: 28,
         child: RaisedButton(
             color: Colors.black,
             child: Text(
               "Follow",
               style:
               TextStyle(color: Color.fromRGBO(212, 27, 71, 1), fontSize: 10),
             ),
             // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
             onPressed: () async {
               await FollowRepo.followOrUnfollow(id, false);
               _asyncKey.currentState.reloadState();

               var userId = await StorageService.getUserId();
               await profileRepo.getUserProfileInfo(userId);
               await followsRepo.getMyFollows(false, true, "");
               _asyncKey.currentState.reloadState();
               // await addSearchproviders.setbool(id, false);
             },
             shape: RoundedRectangleBorder(
                 side:
                 BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
                 borderRadius: new BorderRadius.circular(30.0))),
       );
     });
  }

  Widget followingButton(
    String id,
  ) {
     return Consumer(builder: (context, watch, child) {
       final profileRepo = watch(profileProvider);
       final followsRepo = watch(profileFollow);
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 85,
      height: 28,
      child: RaisedButton(
          color: Color.fromRGBO(212, 27, 71, 1),
          child: Text(
            "Following",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          onPressed: () async {
            await FollowRepo.followOrUnfollow(id, true);
            _asyncKey.currentState.reloadState();
            var userId = await StorageService.getUserId();
            await profileRepo.getUserProfileInfo(userId);
            await followsRepo.getMyFollows(false, true, "");
            _asyncKey.currentState.reloadState();


          },
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
              borderRadius: new BorderRadius.circular(30.0))),
    );
     });
  }
}

//   Widget followerButton(String id) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       width: 85,
//       height: 28,
//       child:
//        RaisedButton(

//       color: _hasBeenPressed ? Colors.yellow : Colors.green,
//           child:
//            _hasBeenPressed ?
//             Text(
//             "Following",
//             style: TextStyle(
//               color: Colors.red,
//                 fontSize: 10),
//           ):  Text(
//             "Follow",
//             style: TextStyle(
//               color: Colors.white,
//                 fontSize: 10),
//           ),
//           // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
//           onPressed: ()async {
//             await FollowRepo.followOrUnfollow(id, false);
//             setState(() {
//                            FollowRepo.followOrUnfollow(id, false);

//               _hasBeenPressed = !_hasBeenPressed;
//             });

//             _asyncfollowerKey.currentState.reloadState();
//           },
//           shape: RoundedRectangleBorder(
//               side:
//                   BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
//               borderRadius: new BorderRadius.circular(30.0))),
//     );
//   }

//   Widget followingButton(String id) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       width: 85,
//       height: 28,
//       child: RaisedButton(
//            color: _hasBeenPressed ? Colors.yellow : Colors.green,
//           child: _hasBeenPressed ?
//             Text(
//             "Follow",
//             style: TextStyle(
//               color: Colors.white,
//                 fontSize: 10),
//           ):  Text(
//             "Following",
//             style: TextStyle(
//               color: Colors.red,
//                 fontSize: 10),
//           ),
//           // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
//           onPressed: () async {
//             await FollowRepo.followOrUnfollow(id, true);
//             setState(() {
//               _hasBeenPressed = !_hasBeenPressed;

//             });
//             _asyncfollowerKey.currentState.reloadState();
//           },
//           shape: RoundedRectangleBorder(
//               side:
//                   BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
//               borderRadius: new BorderRadius.circular(30.0))),
//     );
//   }
// }
