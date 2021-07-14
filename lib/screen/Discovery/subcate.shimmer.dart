import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSubCate extends StatefulWidget {
  @override
  _ShimmerSubCateState createState() => _ShimmerSubCateState();
}

class _ShimmerSubCateState extends State<ShimmerSubCate> {
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
                  height: MediaQuery.of(context).size.height / 3.9,
                  color: Colors.black12,
                child:  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 20,
                  child: new Container(
                    width: 100.0,
                    height: 100.0,
                    child: CircleAvatar(),
                    // decoration: new BoxDecoration(
                    //
                    //   borderRadius:
                    //   new BorderRadius.all(new Radius.circular(50.0)),
                    //   border: new Border.all(
                    //
                    //     width: 4.0,
                    //   ),
                    // ),
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
