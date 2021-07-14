import 'package:flutter/material.dart';

class UserNamePassword extends StatefulWidget {
  @override
  _UserNamePasswordState createState() => _UserNamePasswordState();
}

class _UserNamePasswordState extends State<UserNamePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logo"),
        //31 31 31
        backgroundColor: Color.fromRGBO(31, 31, 31, 1),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        //rgb 160 160 160
        decoration: BoxDecoration(color: Color.fromRGBO(160, 160, 160, 1)),
        child: Column(
          children: [
            SizedBox(
              height: 58,
            ),
            Container(
              //248 248 248
              height: 57,
              width: 328,
              // height: MediaQuery.of(context).size.height/16,
              // width: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  borderRadius: BorderRadius.circular(7)),
              margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Phone Number or Email ",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 32, 14),
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 44,
            ),
            Container(
              //248 248 248
              height: 57,
              width: 328,

              decoration: BoxDecoration(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  borderRadius: BorderRadius.circular(7)),
              margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 32, 14),
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
                child: Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
            SizedBox(
              height: 262,
            ),
            GestureDetector(
              // onTap: ()=> AppNavigator.push(Routes.),

              child: Container(
                  height: 52,
                  width: 231,
                  decoration: BoxDecoration(
                    //rgb 192 29 68
                    color: Color.fromRGBO(192, 29, 68, 1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}
