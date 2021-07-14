import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/login/login.dart';
import 'package:farm_system/feature/sign_up/sign_up.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isRestPassword = false;
  @override
  void initState() {
    context.read(splashProvider).checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Consumer(
            builder: (context, watch, child) {
      final splashRepo = watch(splashProvider);
      return SingleChildScrollView(
          child: Center(
              child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
                // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                // height: 300,
                // width: 300,
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset(splash_logo))),
        Visibility(
            visible: splashRepo.enableSignUpWidget,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 60,
                  width: 280,
                  decoration: BoxDecoration(
                    color: HexColor("#D41B47"),
                    borderRadius: BorderRadius.circular(105),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                      // ExtendedNavigator.root.push(Routes.signUpPage);
                    },
                    child: Center(
                      child: Text(
                        "Create  Account",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  )),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Row(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Do you have an Account? ",
                            // style: TextStyle(
                            //     //fontStyle: GoogleFonts.helveticaNeue(),
                            //     fontSize: 20,
                            //     color: Color.fromRGBO(34, 34, 34, 1)),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: HexColor("#888A8E"),
                              fontSize: 12,
                            ),
                          ),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                      isRestPassword: isRestPassword,
                                    ))),
                        // ExtendedNavigator.root.push(Routes.loginPage),
                        child: Container(
                            child: Text("Log In",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  color: HexColor("#D41B47"),
                                  fontSize: 12,
                                ))),
                      ),
                    ],
                  )),
                ],
              )
            ]))
      ])));
    }));
  }
}
