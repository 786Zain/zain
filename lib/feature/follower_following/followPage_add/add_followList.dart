// ignore: must_be_immutable
import 'dart:async';

import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/feature/follower_following/followPage_add/AddReop/repo.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/feature/profile_user/view/profile_info.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class AddSearchUi extends StatefulWidget {
  final _controller = TextEditingController();
  // Timer _debounce;

  @override
  _AddSearchUiState createState() => _AddSearchUiState();
}

class _AddSearchUiState extends State<AddSearchUi> {
  TextEditingController _Controller = TextEditingController();
  final _asyncfollowerKey = GlobalKey<AsyncLoaderState>();
  Timer _debounce;

@override
void initState() {

    super.initState();
  }




  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(height: 40, child: getsearchWidget(context)),
          getAddPageWidget(context)
        ],
      ),
    );
  }

  Widget getsearchWidget(context) {
    return Container(
      child: Consumer(builder: (context, watch, child) {
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
      }),
    );
  }

  Widget getAddPageWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final profileFollows = watch(profileFollow);
        return AsyncLoader(
          key: _asyncfollowerKey,
          initState: () => profileFollows.getFollows(true, false, ""),
          renderLoad: () => Container(
            height: 0,
            width: 0,
            child: SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 0)),
          ),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateAddsearchUI(context),
        );
      }),
    );
  }

  Widget _generateAddsearchUI(context) {
    // print(context);
    print("search hello-------------------------");
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Consumer(builder: (context, watch, child) {
        final addSearchproviders = watch(addSearchprovider);
        return Column(
          children: [
            addSearchproviders.searchList.isNotEmpty
                ? Container(
                  height: 500,
                    // height: MediaQuery.of(context).size.,
                    child: ListView.builder(
                        itemCount: addSearchproviders.searchList.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 20),
                                        child: CircleAvatar(
                                          radius: 26.0,
                                          backgroundImage: NetworkImage(getImageUrl(
                                                  addSearchproviders
                                                      .searchList[i]
                                                      .profilePic) ??
                                              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                        )),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        // DiscoverySearchRepo.searchList[i].name +
                                        //     ' ' +
                                        addSearchproviders
                                            .searchList[i].userName,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        navigationToScreen(
                                            context,
                                            ProfileTab(
                                              userId: addSearchproviders
                                                  .searchList[i].id,
                                            ),
                                            false);
                                      },
                                    ),
                                    Spacer(),
                                    addSearchproviders
                                                .searchList[i].isFollowing ==
                                            true
                                        ? followingButton(
                                            addSearchproviders.searchList[i].id)
                                        : followerButton(
                                            addSearchproviders.searchList[i].id)
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Center(
                      child: Text(
                        'No Search Users Found',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            letterSpacing: 0.5),
                      ),
                    ),
                  )
          ],
        );
      }),
    );
  }

//Button code

  Widget followerButton(String id) {
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
          await  _asyncfollowerKey.currentState.reloadState();
          },
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget followingButton(String id) {
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
          // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          onPressed: () async {
            await FollowRepo.followOrUnfollow(id, true);
            await _asyncfollowerKey.currentState.reloadState();
          },
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }
}
