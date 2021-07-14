import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/otp/repo/otp_varification_repo.dart';
import 'package:farm_system/feature/resend_otp/repo/resend_otp_repo.dart';
import 'package:farm_system/feature/sign_up/sign_up.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  final String value;
  final String userId;

  const Otp({Key key, this.value, this.userId}) : super(key: key);

  // This widget is the root of your application.
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PinCodeVerificationScreen(
            widget.userId, widget.value, widget.value), // a random number, please don't call xD
      );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  String userId;
  String email;
  String value;

  PinCodeVerificationScreen(this.userId, this.email, this.value);


  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String otpValue;
    return WillPopScope(
       onWillPop: onWillPop,
      child: Center(
        child: Scaffold(
            backgroundColor: Colors.black,
            key: scaffoldKey,
            appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back_ios),
              //   onPressed: (){
              //     onWillPop();
              //   },
              // ),
              title: Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Container(
                    padding: EdgeInsets.only(right: 52),
                    height: 99, child: Center(child: SvgPicture.asset(newLogoFarm))),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'We sent you a Code',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Please enter below to verify\n ${widget.email}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: HexColor("979797"),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              autoFocus: true,
                              pastedTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // backgroundColor: Colors.white,
                              ),
                              length: 6,
                              obscureText: false,
                              obscuringCharacter: '*',
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v.length < 3) {
                                  return "Please enter valid code";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                  inactiveColor: Colors.white,
                                activeColor: Colors.white,
                                selectedColor: Colors.white
                              ),
                              cursorColor: Colors.white,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(
                                  fontSize: 20, height: 1.6,
                                color: Colors.white
                              ),
                              //backgroundColor: Color.fromRGBO(160, 160, 160, 1),
                              backgroundColor: Colors.black,

                              enableActiveFill: false,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,

                              onCompleted: (v) {
                                print("Completed");
                                print(v);
                                otpValue = v;
                              },
                              onTap: () {
                                print("Pressed");
                              },
                              onChanged: (value) {
                                print('dhgdvsvdhs');
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () =>
                              {
                                print(widget.userId),
                                print(widget.email),
                                print(widget.value),
                                ResendOTPRepo.resendOTP(context, widget.value, widget.userId)},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,),
                            child: Text(
                              'Resend Code?',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: HexColor("D41B47"),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 280,
                            height: 60,
                            child: ButtonTheme(
                              // height: 50,
                              child: FlatButton(
                                onPressed: () {
                                  formKey.currentState.validate();
                                  // conditions for validating
                                  if (currentText.length == 6 || currentText != null) {
                                    print("this is step first");
                                    print(otpValue);
                                    print(currentText);
                                    OtpVarificationRepo.otpVerification(context,
                                        widget.email, widget.userId, currentText);
                                    print("if is running ");
                                    errorController.add(ErrorAnimationType.shake);
                                    // Triggering error shake animation
                                    setState(() {
                                      hasError = true;
                                    });
                                  } else {
                                    bool _showMessage = true;
                                    if (_showMessage) {
                                      setState(() {
                                        _showMessage = false;
                                        hasError = true;
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text(" Please check credentials!!"),
                                          duration: Duration(seconds: 2),
                                        ));
                                        print("else is running ");
                                      });
                                      _showMessage = false;
                                    }
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  "Next",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      color: HexColor("FFFFFF"),
                                      fontSize: 14,
                                      textStyle: TextStyle(fontSize: 14)),
                                )),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(192, 29, 68, 1),
                              borderRadius: BorderRadius.circular(105),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            )),
      ),
    );
  }
Future<bool>  onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text('Are you sure?',style: TextStyle(color: Colors.white)),
        content:
        Column(
          mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "You will be only allowed to edit the Email ID/Phone number, so would you like to continue?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop(true);
                      },
                        child: Text('YES', style: TextStyle(color: Colors.white))),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop(false);
                      },
                        child: Text('NO',style: TextStyle(color: Colors.white)))
                  ]),
            )
          ],
        ),
      ),
    );

    return shouldPop ?? false;
  }
}
