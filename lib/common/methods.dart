import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

showFlushBar(context, int duration, content, color,
    {position: FlushbarPosition.BOTTOM}) {
  return Flushbar(
    duration: duration.milliseconds,
    borderRadius: 10,
    margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 30,
        top: position == FlushbarPosition.TOP ? 20 : 0),
    flushbarPosition: position,
    backgroundColor: color,
    flushbarStyle: FlushbarStyle.FLOATING,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    boxShadows: [
      BoxShadow(
        color: Colors.black54,
        offset: Offset(4, 9),
        blurRadius: 7,
      ),
    ],
    messageText: Align(
      alignment: Alignment.center,
      child: Text(
        content,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'QSM',
            fontSize: 22,
            letterSpacing: 2),
      ),
    ),
  )..show(context);
}

imageFileType() {
  return ["jpg", "jpeg", "gif", "png"];
}

getTime(DateTime postDate) {
  final newDate = DateTime.now();
  final hour = newDate.difference(postDate).inHours;
  final minute = newDate.difference(postDate).inMinutes;
  final day = newDate.difference(postDate).inDays;
  if (day / 365 > 1) {
    return "${num.parse((day / 365).toStringAsFixed(0))} ${num.parse((day / 365).toStringAsFixed(0)) > 1 ? "years" : "year"}";
  } else if (day / 30 > 1) {
    return "${num.parse((day / 30).toStringAsFixed(0))} ${num.parse((day / 30).toStringAsFixed(0)) > 1 ? "months" : "month"}";
  } else if (day / 7 > 1) {
    return "${num.parse((day / 7).toStringAsFixed(0))} ${num.parse((day / 7).toStringAsFixed(0)) > 1 ? "weeks" : "week"}";
  } else if (hour / 24 > 1) {
    return "${num.parse((hour / 24).toStringAsFixed(0))} ${num.parse((hour / 24).toStringAsFixed(0)) > 1 ? "d" : "d"}";
  } else if (hour >= 1) {
    return "${num.parse((hour).toStringAsFixed(0))} ${num.parse((hour).toStringAsFixed(0)) > 1 ? "H" : "H"}";
  } else if (minute > 1) {
    return "${num.parse((minute).toStringAsFixed(0))} ${num.parse((minute).toStringAsFixed(0)) > 1 ? "M" : "M"}";
  } else {
    return "now";
  }
}

 getDateShortValues(DateTime postDate) {
  final newDate = DateTime.now();
  final hour = newDate.difference(postDate).inHours;
  final minute = newDate.difference(postDate).inMinutes;
  final day = newDate.difference(postDate).inDays;
  if (day / 365 > 1) {
    return "${num.parse((day / 365).toStringAsFixed(0))} ${num.parse((day / 365).toStringAsFixed(0)) > 1 ? "y" : "y"}";
  } else if (day / 30 > 1) {
    return "${num.parse((day / 30).toStringAsFixed(0))} ${num.parse((day / 30).toStringAsFixed(0)) > 1 ? "m" : "m"}";
  } else if (day / 7 > 1) {
    return "${num.parse((day / 7).toStringAsFixed(0))} ${num.parse((day / 7).toStringAsFixed(0)) > 1 ? "w" : "w"}";
  } else if (hour / 24 > 1) {
    return "${num.parse((hour / 24).toStringAsFixed(0))} ${num.parse((hour / 24).toStringAsFixed(0)) > 1 ? "d" : "d"}";
  } else if (hour > 1) {
    return "${num.parse((hour).toStringAsFixed(0))} ${num.parse((hour).toStringAsFixed(0)) > 1 ? "h" : "h"}";
  } else if (minute > 1) {
    return "${num.parse((minute).toStringAsFixed(0))} ${num.parse((minute).toStringAsFixed(0)) > 1 ? "m" : "m"}";
  } else {
    return "now";
  }
}

getDateFormatMessaging(date) {
  var formattedDate = DateFormat('E, MMM d, ').add_jm().format(date);
  return formattedDate;
}

getImageUrl(url) {
  if (url!=null && !url.contains('https://')) {
    url = 'https://' + url;
  }
  return url;
}
