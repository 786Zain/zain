import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/set_password/repo/set_password_repo.dart';
import 'package:farm_system/update_password/repo/update_password_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String value;
  final String otp;
  const UpdatePasswordScreen({Key key, this.value, this.otp}) : super(key: key);
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerResetPassword = TextEditingController();

  bool _device = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
            height: 99, child: Center(child: SvgPicture.asset(logo_text_left))),
        centerTitle: true,
        //31 31 31
        backgroundColor: Color.fromRGBO(31, 31, 31, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 57,
                width: 328,
                margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
                child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    obscureText: true,
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                        //HexColor("#E0E0E0"),
                        width: 1.5,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor("#E0E0E0"), width: 1.5),
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.padlock,
                        color: HexColor("D41B47"),
                      ),
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          //HexColor("080F18"),
                          fontSize: 16,
                          textStyle: TextStyle(fontSize: 14)),
                    )),
              ),
              SizedBox(
                height: 45,
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
                    obscureText: true,
                    controller: _controllerResetPassword,
                    decoration: InputDecoration(
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        // color: HexColor("080F18"),
                        //8,15,24,1
                        //color: Color.fromRGBO(8, 15, 24, 1),
                        color: HexColor("#E0E0E0"),

                        width: 1.5,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            // color: HexColor("080F18"),
                            color: HexColor("#E0E0E0"),
                            width: 1.5),
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.padlock,
                        color: HexColor("D41B47"),
                      ),
                      hintText: "Confirmation Password",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          //HexColor("080F18"),
                          fontSize: 16,
                          textStyle: TextStyle(fontSize: 14)),
                    )),
              ),
              SizedBox(
                height: 160,
              ),
              GestureDetector(
                onTap: () async {
                  if (_controllerPassword.text ==
                      _controllerResetPassword.text) {
                    UpdatePasswordRepo.otpVarification(context, widget.value,
                        widget.otp, _controllerPassword.text);
                    // ExtendedNavigator.root.push(Routes.signUpPage);
                  } else {
                    CustomWidget.showWarningFlushBar(
                        context, 'Password mis match!');
                  }
                },
                child: Container(
                    height: 60,
                    width: 280,
                    decoration: BoxDecoration(
                      //rgb 192 29 68
                      color: Color.fromRGBO(192, 29, 68, 1),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text(
                        "Finish",
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
      ),
    );
  }
}
