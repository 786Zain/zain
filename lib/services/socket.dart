import 'dart:convert';

import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketLibrary extends ChangeNotifier {
  static SharedPreferences preferences;
  static SocketIO socketIO;
  static connectSocketIo(context) async {
    preferences = await SharedPreferences.getInstance();
   socketIO = SocketIOManager().createSocketIO("http://161.35.118.126:5000", '/', socketStatusCallback: _socketStatus);
    socketIO.init();
    socketIO.connect();
    return "Socket Connected";
  }

  static _socketStatus(dynamic data) async {
    print("${data}");
  }

  static verifyAuth() async {
    final auth = await StorageService.getToken();
    socketIO.sendMessage(
        'set-user',
        json.encode({'token': auth}),
        ((err, data) => {
          if (err) {print("Auth Error-------------------------------------------------$err")},
        }));
  }

  static getSocket(){
    return socketIO;
  }
}
