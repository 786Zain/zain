import 'package:farm_system/screen/Discovery/discovery_serach_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TopNav(int index){
  return AppBar(
    backgroundColor: Colors.black,
    title: index == 1
        ? Container(
      child: DiscoverySearchBar(),
    )
        : Container(
        height: 99,
        child: Center(child:
        Text("The Farm",style: TextStyle(
            fontSize: 15,letterSpacing: 1
        ),)
        )),
    centerTitle: true,
    actions: <Widget>[
      index == 1
          ? Container()
          : IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {},
      )
    ],
  );
}

Widget switchappbars(index){
  if(index==1){
    return Container(
      child: DiscoverySearchBar(),
    );
  }
  else if(index == 2){

  }
}
