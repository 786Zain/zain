import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child:  Container(
          // height: 1500,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    color: Colors.black12,
                    child:  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 7.5,
                    left: 20,
                    child: new Container(
                      width: 100.0,
                      height: 100.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black12,
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        )

    );
  }
  }


