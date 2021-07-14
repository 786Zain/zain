import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedLoaderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  period: Duration(milliseconds: 500),
                  child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black26,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                  ),
                                                  flex: 5,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(right: 4.0),
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 16, left: 5),
                                                    ),
                                                  ),flex: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 4.0),
                                            child:  Visibility(
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10.0)),
                                                  color: Colors.white30),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(0.0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10, top: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 70),
                                                    child:  Container(
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 200,
                                                      margin: EdgeInsets.only(top: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) ,

                                          Padding(
                                            padding: EdgeInsets.only(left: 0, right:0.0, top: 8.0, bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: [],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ))
              ))
        ]));
  }
}


