import 'dart:async';

import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/forgetPassword/repo/newforgotPassword.dart';
import 'package:farm_system/feature/resend_otp/repo/resend_otp_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  final String value;

  const ForgetPasswordOTPScreen({Key key, @required this.value})
      : super(key: key);
  // This widget is the root of your application.
  @override
  _ForgetPasswordOTPScreenState createState() =>
      _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinCodeVerificationScreen("345345345435435",
          widget.value), // a random number, please don't call xD
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  String phoneNumber;
  String email;

  PinCodeVerificationScreen(this.phoneNumber, this.email);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

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
    return Center(
        child: Scaffold(
            //backgroundColor: Colors.blue.shade50,
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                iconSize: 32,
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Container(
                  height: 99,
                  child: Center(child: SvgPicture.asset(logo_text_left))),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Container(
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
                          color: Colors.white
                          //HexColor("666666"),
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
                          fontSize: 12,
                          color: Colors.white
                          //HexColor("979797"),
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
                            pastedTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
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
                                activeColor:HexColor("979797"),
                                //inactiveColor: Color.fromRGBO(160, 160, 160, 1),
                                inactiveColor: HexColor("979797"),
                                disabledColor: Color.fromRGBO(132, 132, 132, 1),
                                // inactiveFillColor: Color.fromRGBO(190, 190, 193, 1),
                                inactiveFillColor: Colors.black,

                                //selectedColor: Color.fromRGBO(160, 160, 160, 1),
                                selectedColor: HexColor("979797"),
                                // selectedFillColor:
                                //     Color.fromRGBO(160, 160, 160, 1),

                                selectedFillColor: Colors.black,
                                //shape: PinCodeFieldShape.underline,
                                //borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 50,
                                // activeFillColor: hasError
                                //     ? Color.fromRGBO(160, 160, 160, 1)
                                //     : Color.fromRGBO(160, 160, 160, 1),
                                activeFillColor:
                                    hasError ? Colors.black : Colors.black),
                            cursorColor: Colors.white,
                            animationDuration: Duration(milliseconds: 300),
                            textStyle: TextStyle(fontSize: 20, height: 1.6,color: Colors.white),
                            //backgroundColor: Color.fromRGBO(160, 160, 160, 1),
                            backgroundColor: Colors.black,

                            enableActiveFill: true,
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
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 60,
                          // margin: const EdgeInsets.symmetric(
                          //     vertical: 16.0, horizontal: 80),
                          child: ButtonTheme(
                            // height: 50,
                            child: FlatButton(
                              onPressed: () {
                                formKey.currentState.validate();
                                // conditions for validating
                                if (currentText.length == 4 ||
                                    otpValue != null) {
                                  OtpVarificationNewRepo1.otpVarification(
                                      context, widget.email, otpValue);
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
                                      hasError = false;
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal),
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
                  ]),
            )));
  }
}
