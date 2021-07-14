//
// import 'package:prefs_guard/prefsguard.dart';
//
// class StorageService {
//   static final prefs = PrefsGuard(GuardType.AES);
//
//   static read(k) async {
//     return prefs.read(key: k);
//   }
//
//   static write(k, v) {
//     prefs.write(key: k, value: v);
//   }
//
//   static clearPrefs() {
//     prefs.clearAll();
//   }
//
//   static setToken(v) {
//     prefs.write(key: PrefsConstatnts.token, value: v);
//   }
//
//   static setEmail(v) {
//     prefs.write(key: PrefsConstatnts.email, value: v);
//   }
//
//   static setUserId(v) {
//     prefs.write(key: PrefsConstatnts.userid, value: v);
//   }
//
//   static setOtp(v) {
//     prefs.write(key: PrefsConstatnts.otp, value: v);
//   }
//
//   static getToken() {
//     return read(PrefsConstatnts.token);
//   }
//   static getPermission() async {
//     return await read(PrefsConstants.permission);
//   }
//
//   static getEmail() async {
//     return await read(PrefsConstants.email);
//   }
//
//   static getUserId() async {
//     return await read(PrefsConstants.userid);
//   }
//
//   static getOtp() async {
//     return await read(PrefsConstants.otp);
//   }
// }
