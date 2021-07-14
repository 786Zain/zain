import 'package:farm_system/constant/constants.dart';
import 'package:prefs_guard/prefsguard.dart';

class StorageService {
  static final prefs = PrefsGuard(GuardType.AES);

  static read(k) async {
    return prefs.read(key: k);
  }

  static write(k, v) {
    prefs.write(key: k, value: v);
  }

  static clearPrefs() {
    prefs.clearAll();
  }

  static setToken(v) {
    prefs.write(key: PrefsConstants.token, value: v);
  }

  static getToken() {
    return prefs.read(key: PrefsConstants.token);
  }


  static setResendUserId(v) {
    prefs.write(key: PrefsConstants.resendUserId, value: v);
  }

  static getResendUserId() {
    return prefs.read(key: PrefsConstants.resendUserId);
  }

  static setUserName(v) {
    prefs.write(key: PrefsConstants.userName, value: v);
  }

  static setName(v) {
    prefs.write(key: PrefsConstants.name, value: v);
  }

  static getName() {
    return prefs.read(key: PrefsConstants.name);
  }

  static getUserName() {
    return prefs.read(key: PrefsConstants.userName);
  }

  static setUserProfile(v) {
    prefs.write(key: PrefsConstants.userProfile, value: v);
  }

  static getUserProfile() {
    return prefs.read(key: PrefsConstants.userProfile);
  }

  static setUserId(v) {
    prefs.write(key: PrefsConstants.userId, value: v);
  }

  static getUserId() {
    return prefs.read(key: PrefsConstants.userId);
  }

  static setEmail(v) {
    prefs.write(key: PrefsConstants.email, value: v);
  }

  static setPassword(v) {
    prefs.write(key: PrefsConstants.password, value: v);
  }

  static getEmail() {
    return prefs.read(key: PrefsConstants.email);
  }

  static getPassword() {
    return prefs.read(key: PrefsConstants.password);
  }

  static setPhoneNo(v) {
    prefs.write(key: PrefsConstants.phone, value: v);
  }

  static getPhone() {
    return prefs.read(key: PrefsConstants.phone);
  }

  static setPPhoneNo(v) {
    prefs.write(key: PrefsConstants.plivoPhoneNumber, value: v);
  }

  static getPPhone() {
    return prefs.read(key: PrefsConstants.plivoPhoneNumber);
  }

  static setDeviceToken(v) {
    prefs.write(key: PrefsConstants.deviceToken, value: v);
  }

  static getDeviceToken() {
    return prefs.read(key: PrefsConstants.deviceToken);
  }
}
