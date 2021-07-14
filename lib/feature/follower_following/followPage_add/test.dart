import 'dart:async';

import 'package:farm_system/feature/follower_following/Following/views/following_list.dart';
import 'package:farm_system/feature/follower_following/followPage_add/AddReop/globalsearch_list.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController _Controller = TextEditingController();
  Timer _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          Consumer(builder: (context, watch, child) {
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
          Expanded(child: GlobalSearchPage())
        ]));
  }
}
