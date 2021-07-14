import 'package:auto_route/auto_route.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/login/repo/login.repo.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/services/push_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  final bool isRestPassword;

  const LoginPage({Key key, this.isRestPassword}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isVisiblePassword = true;

  final whiteColor = Colors.white;

  @override
  Future<void> initState() {
    // TODO: implement initState
    PushNotificationsManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.isRestPassword
          ? AppBar(
              title: Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Container(
                    height: 99,
                    child: Center(child: SvgPicture.asset(newLogoFarm))),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            )
          : AppBar(
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                iconSize: 32,
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Padding(
                padding: EdgeInsets.only(top:18.0,right: 50),
                child: Container(
                    height: 99,
                    child: Center(child: SvgPicture.asset(newLogoFarm))),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Container(
                width: 320,
                child: TextFormField(
                    // cursorColor: HexColor("080F18"),
                  cursorColor: whiteColor,
                    style: TextStyle(
                      color: whiteColor
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Username, Phone Number or Email",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          // color: HexColor("080F18")
                        color: Colors.white
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
                            color: whiteColor,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 320,
                child: TextFormField(
                    // cursorColor: HexColor("080F18"),
                  cursorColor: whiteColor,
                    controller: _passwordController,
                    obscureText: _isVisiblePassword ? true : false,
                    style: TextStyle(
                      color: whiteColor
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        color: HexColor("C4C4C4"),
                        onPressed: () {
                          setState(() {
                            _isVisiblePassword = !_isVisiblePassword;
                          });
                        },
                        icon: _isVisiblePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility_rounded),
                      ),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                         color: Colors.white,),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: HexColor("D41B47"),
                      ),
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
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => ExtendedNavigator.root
                          .push(Routes.forgetPasswordEmailScreen),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0, 0, MediaQuery.of(context).size.width / 11, 0),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                              color: HexColor("D41B47"),
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              decoration: TextDecoration.underline),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                SizedBox(width: 40),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 40,
                  width: 40,
                  color: HexColor("#F9F9FC"),
                  child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#f2f2f7"),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: SvgPicture.asset(googleImage, fit: BoxFit.none)),
                ),
                // SizedBox(
                //   width: 15,
                // ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 40,
                  width: 40,
                  color: HexColor("#F9F9FC"),
                  child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#f2f2f7"),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: SvgPicture.asset(facebookImage, fit: BoxFit.none)),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 40,
                  width: 40,
                  color: HexColor("#F9F9FC"),
                  child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#f2f2f7"),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: SvgPicture.asset(twitterImage,
                              fit: BoxFit.none))),
                )
              ]),
              SizedBox(
                height: 160,
              ),
              Container(
                  height: 60,
                  width: 280,
                  decoration: BoxDecoration(
                    color: HexColor("#D41B47"),
                    borderRadius: BorderRadius.circular(105),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(105)),
                    onPressed: () {
                      LoginRepo.login(context, _emailController.text.trim(),
                          _passwordController.text.trim());
                    },
                    child: Center(
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  )),
              SizedBox(
                height: 7,
              ),
              GestureDetector(
                  onTap: () => ExtendedNavigator.root.push(Routes.signUpPage),
                  child: Container(
                    child: Text(
                      "Need to Sign up?",
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: HexColor("888A8E")),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
