import 'dart:async';

import 'package:farm_system/feature/follower_following/Following/views/following_list.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Following extends StatefulWidget {
  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
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
                      profileFollows.getFollows(false, true, _Controller.text);
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
                  contentPadding: EdgeInsets.only(bottom: 4, top: 4),
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }),
          Flexible(child: FollowingList())
        ]));
  }
}
