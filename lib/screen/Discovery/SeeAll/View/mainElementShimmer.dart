import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainImageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black26,
                  ),
              );
  }
}


