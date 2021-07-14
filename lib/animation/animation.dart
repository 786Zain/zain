import 'package:flutter/material.dart';

class SlideFromRight extends PageRouteBuilder {
  final Widget widget;
  SlideFromRight({this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(2.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            });
}

class Pagetransition extends PageRouteBuilder {
  final Widget widget;
  Pagetransition({this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            });
}
