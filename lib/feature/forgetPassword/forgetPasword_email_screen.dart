import 'package:auto_route/auto_route.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/forgetPassword/repo/forgotPassowrdRepo.dart';
import 'package:farm_system/feature/login/repo/login.repo.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordEmailScreen> {
  final _emailController = TextEditingController();

  bool token = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          iconSize: 32,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
            height: 99, child: Center(child: SvgPicture.asset(logo_text_left))),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              //248 248 248
              height: 57,
              width: 328,
              margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
              child: TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Phone Number or Email",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.white
                        // HexColor("080F18")
                        ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: HexColor("D41B47"),
                    ),
                    //border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 1.5,
                      color: HexColor("#E0E0E0"),
                    )),
                    focusedBorder: UnderlineInputBorder(
                      //8,15,24,1
                      borderSide: BorderSide(
                        width: 1.5,
                        //color: Color.fromRGBO(8, 18, 24, 1)
                        color: HexColor("#E0E0E0"),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () async {
                await ForgotPasswordRepo.forgotPassword(
                    context, _emailController.text, token);
              },
              child: Container(
                  height: 60,
                  width: 280,
                  decoration: BoxDecoration(
                    //rgb 192 29 68
                    color: Color.fromRGBO(192, 29, 68, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 14, color: Colors.white),
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
