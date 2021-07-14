
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'dart:ui';

class ForgetNewPassword extends StatefulWidget {
  @override
  _ForgetNewPasswordState createState() => _ForgetNewPasswordState();
}

class _ForgetNewPasswordState extends State<ForgetNewPassword> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final body = Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'new password is required' : null,
              controller: _controller,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "New password",
                  hintStyle: TextStyle(color: Colors.grey)),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 16),
//          Text('Enter your email above, and we’ll send you\n instructions to reset your password.',
//              style: GoogleFonts.openSans(
//                  fontSize: 16,
//                  fontStyle: FontStyle.normal,
//                  fontWeight: FontWeight.w600,
//                  color: Colors.black)
//          ),
          SizedBox(height: 100),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
            onTap: ( ) async {
              // await NewPasswordRepo.newPassword(context,_controller.text);
            },
          )
        ],
      ),
    );
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.only(left: 50),
          child:  Text(
            'New Password',
            style: GoogleFonts.openSans(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: Colors.deepOrange),
          ),
        ),
        leading: GestureDetector(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.deepOrange,
                ),
                onPressed: null),
            onTap: () {}),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            body
          ],
        ),
      ),
    );
  }
}