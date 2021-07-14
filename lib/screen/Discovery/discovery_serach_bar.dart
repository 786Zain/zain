import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';

class DiscoverySearchBar extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    TextEditingController _Controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      height: 40,
      //color: Colors.grey,
      margin: EdgeInsets.only(
        left: 0,
        right: 10,
        top: 10,
      ),
      child: TextFormField(
        controller: _Controller,
        showCursor: false,
        cursorColor: Colors.white,
        onChanged: (value) {},
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search the farm',
          contentPadding: EdgeInsets.only(bottom: 2, top: 4),
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
