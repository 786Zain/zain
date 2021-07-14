import 'package:flutter/material.dart';

Widget customFadeRoute(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    transformHitTests: false,
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(animation),
    child: FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.0, -1.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    ),
  );
}