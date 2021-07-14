import 'dart:ui';

import 'package:farm_system/feature/follower_following/Following/views/following_list.dart';
import 'package:farm_system/feature/follower_following/followPage.dart';
import 'package:farm_system/feature/follower_following/followPage_add/AddReop/globalsearch_list.dart';
import 'package:farm_system/feature/follower_following/followPage_add/AddReop/repo.dart';
import 'package:farm_system/feature/follower_following/followPage_add/add_followList.dart';
import 'package:farm_system/feature/follower_following/followPage_add/test.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class AddFollowUi extends ConsumerWidget {
  final _controller = TextEditingController();
  String searchKey;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: non_constant_identifier_names
    final addSearchproviders = watch(addSearchprovider);
    final profileRepo = watch(profileProvider);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.grey[900],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                addSearchproviders.searchList.clear();
                // AddSearchRepo.searchList.clear();
              },
              padding: EdgeInsets.only(top: 7),
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey,)),
          title: Center(
            child: new InkWell(
              onTap: () {},
              child: new Container(
                  child: Text(
                profileRepo.userProfileDeatils.name.toUpperCase(),
                style: TextStyle(fontSize: 14),
              )),
            ),
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          Expanded(child: GlobalSearchPage())
        ]));
  }
}
