// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../camera/camera.dart';
import '../camera/camera_form_gallery_view.dart';
import '../camera/video.dart';
import '../dashboard/dashboard.dart';
import '../feature/farm_post/custom_gallery.dart';
import '../feature/farm_post/farm_post.dart';
import '../feature/first_screen/first_screen.dart';
import '../feature/forgetPassword/forgetPasword_email_screen.dart';
import '../feature/login/login.dart';
import '../feature/otp/forget_password_otp_screen.dart';
import '../feature/otp/otp.dart';
import '../feature/profile_setUp/profile_setup_page1.dart';
import '../feature/profile_setUp/profile_setup_page2.dart';
import '../feature/set_password/set_password.dart';
import '../feature/sign_up/sign_up.dart';
import '../feature/splash/splash.dart';
import '../feature/user_name_password/user_name_password.dart';
import '../post_tweet/post_tweet.dart';
import '../update_password/update_password.dart';

class Routes {
  static const String splashScreen = '/';
  static const String firstScreen = '/first-screen';
  static const String loginPage = '/login-page';
  static const String signUpPage = '/sign-up-page';
  static const String forgetPasswordEmailScreen =
      '/forget-password-email-screen';
  static const String otp = '/Otp';
  static const String postTweetPage = '/post-tweet-page';
  static const String updatePasswordScreen = '/update-password-screen';
  static const String cameraExampleHome = '/camera-example-home';
  static const String video = '/Video';
  static const String forgetPasswordOTPScreen = '/forget-password-ot-pScreen';
  static const String setPasswordScreen = '/set-password-screen';
  static const String userNamePassword = '/user-name-password';
  static const String profileSetupPage1 = '/profile-setup-page1';
  static const String profileSetupPage2 = '/profile-setup-page2';
  static const String dashBoard = '/dash-board';
  static const String displayPictureScreen1 = '/display-picture-screen1';
  static const String customGallery = '/custom-gallery';
  static const String farmPost = '/farm-post';
  static const all = <String>{
    splashScreen,
    firstScreen,
    loginPage,
    signUpPage,
    forgetPasswordEmailScreen,
    otp,
    postTweetPage,
    updatePasswordScreen,
    cameraExampleHome,
    video,
    forgetPasswordOTPScreen,
    setPasswordScreen,
    userNamePassword,
    profileSetupPage1,
    profileSetupPage2,
    dashBoard,
    displayPictureScreen1,
    customGallery,
    farmPost,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.firstScreen, page: FirstScreen),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.signUpPage, page: SignUpPage),
    RouteDef(Routes.forgetPasswordEmailScreen, page: ForgetPasswordEmailScreen),
    RouteDef(Routes.otp, page: Otp),
    RouteDef(Routes.postTweetPage, page: PostTweetPage),
    RouteDef(Routes.updatePasswordScreen, page: UpdatePasswordScreen),
    RouteDef(Routes.cameraExampleHome, page: CameraExampleHome),
    RouteDef(Routes.video, page: Video),
    RouteDef(Routes.forgetPasswordOTPScreen, page: ForgetPasswordOTPScreen),
    RouteDef(Routes.setPasswordScreen, page: SetPasswordScreen),
    RouteDef(Routes.userNamePassword, page: UserNamePassword),
    RouteDef(Routes.profileSetupPage1, page: ProfileSetupPage1),
    RouteDef(Routes.profileSetupPage2, page: ProfileSetupPage2),
    RouteDef(Routes.dashBoard, page: DashBoard),
    RouteDef(Routes.displayPictureScreen1, page: DisplayPictureScreen1),
    RouteDef(Routes.customGallery, page: CustomGallery),
    RouteDef(Routes.farmPost, page: FarmPost),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    FirstScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FirstScreen(),
        settings: data,
      );
    },
    LoginPage: (data) {
      final args = data.getArgs<LoginPageArguments>(
        orElse: () => LoginPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPage(
          key: args.key,
          isRestPassword: args.isRestPassword,
        ),
        settings: data,
      );
    },
    SignUpPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpPage(),
        settings: data,
      );
    },
    ForgetPasswordEmailScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgetPasswordEmailScreen(),
        settings: data,
      );
    },
    Otp: (data) {
      final args = data.getArgs<OtpArguments>(
        orElse: () => OtpArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Otp(
          key: args.key,
          value: args.value,
          userId: args.userId,
        ),
        settings: data,
      );
    },
    PostTweetPage: (data) {
      final args = data.getArgs<PostTweetPageArguments>(
        orElse: () => PostTweetPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PostTweetPage(
          key: args.key,
          filePath: args.filePath,
          isImage: args.isImage,
        ),
        settings: data,
      );
    },
    UpdatePasswordScreen: (data) {
      final args = data.getArgs<UpdatePasswordScreenArguments>(
        orElse: () => UpdatePasswordScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => UpdatePasswordScreen(
          key: args.key,
          value: args.value,
          otp: args.otp,
        ),
        settings: data,
      );
    },
    CameraExampleHome: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CameraExampleHome(),
        settings: data,
      );
    },
    Video: (data) {
      final args = data.getArgs<VideoArguments>(
        orElse: () => VideoArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Video(
          key: args.key,
          textTyped: args.textTyped,
          id: args.id,
          subCategory: args.subCategory,
          commentPostImage: args.commentPostImage,
          profilePicUser: args.profilePicUser,
          adminPicUser: args.adminPicUser,
          userNamePost: args.userNamePost,
          postId: args.postId,
          parentId: args.parentId,
          parentUserId: args.parentUserId,
          grandParentId: args.grandParentId,
          userId: args.userId,
          userName: args.userName,
        ),
        settings: data,
      );
    },
    ForgetPasswordOTPScreen: (data) {
      final args =
          data.getArgs<ForgetPasswordOTPScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgetPasswordOTPScreen(
          key: args.key,
          value: args.value,
        ),
        settings: data,
      );
    },
    SetPasswordScreen: (data) {
      final args = data.getArgs<SetPasswordScreenArguments>(
        orElse: () => SetPasswordScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetPasswordScreen(
          key: args.key,
          value: args.value,
          userId: args.userId,
        ),
        settings: data,
      );
    },
    UserNamePassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserNamePassword(),
        settings: data,
      );
    },
    ProfileSetupPage1: (data) {
      final args = data.getArgs<ProfileSetupPage1Arguments>(
        orElse: () => ProfileSetupPage1Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileSetupPage1(
          key: args.key,
          value: args.value,
          password: args.password,
          userId: args.userId,
        ),
        settings: data,
      );
    },
    ProfileSetupPage2: (data) {
      final args = data.getArgs<ProfileSetupPage2Arguments>(
        orElse: () => ProfileSetupPage2Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileSetupPage2(
          key: args.key,
          value: args.value,
          password: args.password,
          userId: args.userId,
          skip: args.skip,
        ),
        settings: data,
      );
    },
    DashBoard: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DashBoard(),
        settings: data,
      );
    },
    DisplayPictureScreen1: (data) {
      final args = data.getArgs<DisplayPictureScreen1Arguments>(
        orElse: () => DisplayPictureScreen1Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DisplayPictureScreen1(
          key: args.key,
          imagePath: args.imagePath,
          portrait: args.portrait,
          textTyped: args.textTyped,
          id: args.id,
          subCategory: args.subCategory,
          commentPostImage: args.commentPostImage,
          profilePicUser: args.profilePicUser,
          adminPicUser: args.adminPicUser,
          userNamePost: args.userNamePost,
          postId: args.postId,
          parentId: args.parentId,
          parentUserId: args.parentUserId,
          grandParentId: args.grandParentId,
          subcategoryId: args.subcategoryId,
          mainCategoryId: args.mainCategoryId,
          userId: args.userId,
          userName: args.userName,
        ),
        settings: data,
      );
    },
    CustomGallery: (data) {
      final args = data.getArgs<CustomGalleryArguments>(
        orElse: () => CustomGalleryArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CustomGallery(
          key: args.key,
          textTyped: args.textTyped,
          id: args.id,
          subCategory: args.subCategory,
          commentPostImage: args.commentPostImage,
          profilePicUser: args.profilePicUser,
          userNamePost: args.userNamePost,
          adminPicUser: args.adminPicUser,
          postId: args.postId,
          parentId: args.parentId,
          parentUserId: args.parentUserId,
          grandParentId: args.grandParentId,
          subcategoryId: args.subcategoryId,
          mainCategoryId: args.mainCategoryId,
          userId: args.userId,
          userName: args.userName,
        ),
        settings: data,
      );
    },
    FarmPost: (data) {
      final args = data.getArgs<FarmPostArguments>(
        orElse: () => FarmPostArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FarmPost(
          key: args.key,
          filePath: args.filePath,
          duration: args.duration,
          portraits: args.portraits,
          id: args.id,
          subCategory: args.subCategory,
          textTyped: args.textTyped,
          categoryId: args.categoryId,
          subcategoryId: args.subcategoryId,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginPage arguments holder class
class LoginPageArguments {
  final Key key;
  final bool isRestPassword;
  LoginPageArguments({this.key, this.isRestPassword});
}

/// Otp arguments holder class
class OtpArguments {
  final Key key;
  final String value;
  final String userId;
  OtpArguments({this.key, this.value, this.userId});
}

/// PostTweetPage arguments holder class
class PostTweetPageArguments {
  final Key key;
  final File filePath;
  final bool isImage;
  PostTweetPageArguments({this.key, this.filePath, this.isImage});
}

/// UpdatePasswordScreen arguments holder class
class UpdatePasswordScreenArguments {
  final Key key;
  final String value;
  final String otp;
  UpdatePasswordScreenArguments({this.key, this.value, this.otp});
}

/// Video arguments holder class
class VideoArguments {
  final Key key;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId;
  final String parentUserId;
  final String grandParentId;
  final String userId;
  final String userName;
  VideoArguments(
      {this.key,
      this.textTyped,
      this.id,
      this.subCategory,
      this.commentPostImage,
      this.profilePicUser,
      this.adminPicUser,
      this.userNamePost,
      this.postId,
      this.parentId,
      this.parentUserId,
      this.grandParentId,
      this.userId,
      this.userName});
}

/// ForgetPasswordOTPScreen arguments holder class
class ForgetPasswordOTPScreenArguments {
  final Key key;
  final String value;
  ForgetPasswordOTPScreenArguments({this.key, @required this.value});
}

/// SetPasswordScreen arguments holder class
class SetPasswordScreenArguments {
  final Key key;
  final String value;
  final String userId;
  SetPasswordScreenArguments({this.key, this.value, this.userId});
}

/// ProfileSetupPage1 arguments holder class
class ProfileSetupPage1Arguments {
  final Key key;
  final String value;
  final String password;
  final String userId;
  ProfileSetupPage1Arguments(
      {this.key, this.value, this.password, this.userId});
}

/// ProfileSetupPage2 arguments holder class
class ProfileSetupPage2Arguments {
  final Key key;
  final String value;
  final String password;
  final String userId;
  final bool skip;
  ProfileSetupPage2Arguments(
      {this.key, this.value, this.password, this.userId, this.skip});
}

/// DisplayPictureScreen1 arguments holder class
class DisplayPictureScreen1Arguments {
  final Key key;
  final File imagePath;
  final bool portrait;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId;
  final String parentUserId;
  final String grandParentId;
  final String subcategoryId;
  final String mainCategoryId;
  final String userId;
  final String userName;
  DisplayPictureScreen1Arguments(
      {this.key,
      this.imagePath,
      this.portrait,
      this.textTyped,
      this.id,
      this.subCategory,
      this.commentPostImage,
      this.profilePicUser,
      this.adminPicUser,
      this.userNamePost,
      this.postId,
      this.parentId,
      this.parentUserId,
      this.grandParentId,
      this.subcategoryId,
      this.mainCategoryId,
      this.userId,
      this.userName});
}

/// CustomGallery arguments holder class
class CustomGalleryArguments {
  final Key key;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String userNamePost;
  final String adminPicUser;
  final String postId;
  final String parentId;
  final String parentUserId;
  final String grandParentId;
  final String subcategoryId;
  final String mainCategoryId;
  final String userId;
  final String userName;
  CustomGalleryArguments(
      {this.key,
      this.textTyped,
      this.id,
      this.subCategory,
      this.commentPostImage,
      this.profilePicUser,
      this.userNamePost,
      this.adminPicUser,
      this.postId,
      this.parentId,
      this.parentUserId,
      this.grandParentId,
      this.subcategoryId,
      this.mainCategoryId,
      this.userId,
      this.userName});
}

/// FarmPost arguments holder class
class FarmPostArguments {
  final Key key;
  final File filePath;
  final Duration duration;
  final bool portraits;
  final String id;
  final String subCategory;
  final String textTyped;
  final String categoryId;
  final String subcategoryId;
  FarmPostArguments(
      {this.key,
      this.filePath,
      this.duration,
      this.portraits,
      this.id,
      this.subCategory,
      this.textTyped,
      this.categoryId,
      this.subcategoryId});
}
