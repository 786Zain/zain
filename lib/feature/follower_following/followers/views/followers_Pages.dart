import 'dart:async';

import 'package:farm_system/feature/follower_following/followers/views/followers_list.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class Follower extends StatefulWidget {
  @override
  _FollowerState createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  TextEditingController _Controller = TextEditingController();
  Timer _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          Consumer(builder: (context, watch, child) {
            final profileFollows = watch(profileFollow);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade900,
              ),
              height: 35,
              //color: Colors.grey,
              margin: EdgeInsets.only(
                left: 15,
                right: 10,
                top: 10,
              ),
              child: TextFormField(
                onChanged: (T) {
                  if (_debounce?.isActive ?? false) _debounce.cancel();
                  _debounce = Timer(const Duration(milliseconds: 800), () {
                    setState(() {
                      profileFollows.getFollows(true, false, _Controller.text);
                      // profileFollows.getFollows(false, true, _Controller.text);
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
                  contentPadding: EdgeInsets.only(bottom: 4, top: 4,left:0),
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }),
          Flexible(child: FollowerList())
        ]));
  }
}
