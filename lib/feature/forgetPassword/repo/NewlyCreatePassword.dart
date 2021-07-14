// import 'dart:convert';
//
// import 'package:farm_system/common/custom_widget.dart';
// import 'package:farm_system/feature/set_password/set_password.dart';
// import 'package:farm_system/services/network/api.dart';
// import 'package:farm_system/services/network/dio_client.dart';
// import 'package:flutter/material.dart';
// import 'package:validators/validators.dart';
// import 'package:dio/dio.dart';
//
// class OtpVarificationNewlyCreatedRepo {
//   static otpVarification(BuildContext context, String email,String password, String ComfirmPassword, String otp, device) {
//     if (isNull(email)) {
//       CustomWidget.showWarningFlushBar(context, 'Invalid Email');
//     } else if (!isEmail(email)) {
//       CustomWidget.showWarningFlushBar(context, 'Please enter valid email');
//     } else if (isNull(otp)) {
//       CustomWidget.showWarningFlushBar(context, 'Please otp');
//     }
//     else if (password!=ComfirmPassword) {
//       CustomWidget.showWarningFlushBar(context, 'Please new password and comfirm password not matched');
//     }else {
//       print('here is otp ${otp}');
//       _callOtpVaricationApi(context, email, otp, password,ComfirmPassword, device );
//     }
//   }
//
//   static _callOtpVaricationApi(BuildContext context, email, otp, password,ComfirmPassword, device) {
//     try {
//       final _apiCall = RestClient(DioClient.getDio());
//       Map map = {"newPassword": password};
//
//       _apiCall.setNewPassowrd(device,email,otp,json.encode(map)).then((data) async {
//         CustomWidget.showSuccessFlushBar(context, 'Varifying...');
//         String permission = "granted";
//         Future.delayed(const Duration(milliseconds: 300), () {
//           if (permission == "granted") {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => SetPasswordScreen(email: email)));
//           }
//         });
//       }).catchError((err) {
//         print("testing ...");
//         final error = (err as DioError).response;
//         if (error.statusCode == 500) {
//           CustomWidget.showWarningFlushBar(context, "OTP Code Invalid");
//         } else {
//           CustomWidget.showWarningFlushBar(context, 'Something went wrong');
//         }
//       });
//     } catch (e) {}
//   }
// }
