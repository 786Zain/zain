import 'package:flutter/material.dart';

const splash_logo = "assets/images/logo.png";
const horizontal_logo = "assets/images/thefarm.svg";
const logo_text_left = "assets/images/logo_with_text_left.svg";
const farm_plus_logo = "assets/images/Farm_plus_logo.png";
const middle_logo = "assets/images/BaseBall_logo.png";
const gallery = "assets/images/gallery.svg";
const user = "assets/images/image.jpeg";
const dummyUser = "assets/images/user.png";
const feedImage = "assets/images/Feed.svg";
const discovery = "assets/images/discovery.svg";
const red = "assets/images/red.svg";
const message = "assets/images/message.svg";
const profile = "assets/images/profile.svg";
const googleImage = "assets/images/google.svg";
const facebookImage = "assets/images/facebook.svg";
const twitterImage = "assets/images/twitter.svg";
const camera = "assets/images/camera.svg";
const video = "assets/images/video.svg";
const location = "assets/images/location.svg";
const settings = "assets/images/settings.svg";
const reply = "assets/images/reply.svg";
const person = "assets/images/person.png";
const lock = "assets/images/lock.png";
const earth = "assets/images/earth.png";
const privacyEarth = "assets/images/privacyEarth.png";
const rightMark = "assets/images/rightMark.png";
const likeIcon = "assets/images/like.png";
const unLikeIcon = "assets/images/unlike.svg";
const commentIcon = "assets/images/comment.svg";
const retweetIcon = "assets/images/retweet.png";
const bookMarkIcon = "assets/images/bookMark.svg";
const gridcam="assets/images/gridcam.png";
const grids="assets/images/grids.svg";
const gg="assets/images/ggg.svg";
const bookmark="assets/images/upload2.png";
const home="assets/images/home.svg";
const discovery1 = "assets/images/discovery1.svg";
const notification = "assets/images/notification.svg";
const newFarm = "assets/images/faemIcon.svg";
const thenewFarm = "assets/images/farmNewLogo.svg";
const discoverEdit = "assets/images/discoveredit.svg";
const centerLogo ="assets/images/centerlogo.svg";

const discoverySearch = "assets/images/DiscoverySearchmessage.png";
const centerLogogo ="assets/images/centerlogo1.png";
const repostNewImage = "assets/images/RepostNew.svg";
const newLogoFarm = "assets/images/newLogoFarm.svg";
const repeatIocn = "assets/images/repeatIcon.svg";
const repostBottom = "assets/images/repostBottom.svg";
const gallery_outlined = "assets/images/gallery.png";
const camera_outlined = "assets/images/camera.png";
const discoverNewIcon = "assets/images/search.svg";
const repostColor = "assets/images/RepostColor.svg";
const newMessage = "assets/images/messagenew.svg";
const lap = "assets/images/lap.svg";
const newone = "assets/images/newone.svg";
const commentRed = "assets/images/newRedOne.svg";
const homeIcon = "assets/images/homeIcon.svg";
const searchIcons = "assets/images/searchNewIcon.svg";



List<String> imageFileTypes = [
  "png",
  "jpg",
  "jpeg",
  "gif",
  "JPG",
  "PNG",
  "JPEG",
  "GIF",
  "HEIC"
];



//colors
const blue_back_color = Color(0xFF32B5E2);
final warningRed = Colors.red[800];
final successLoginColor = Colors.green[500];
final blueGre7 = Colors.blueGrey[700];
final blueGre8 = Colors.blueGrey[800];


//const BASE_API_URL = "http://192.168.0.164:5000/api/";
//
//   const BASE_API_URL = "https://c64ee17c4ff3.ngrok.io/api/";

  const BASE_API_URL = "http://161.35.118.126/api/";




class PrefsConstants {
  static final token = "token";
  static final userName = "userName";
  static final name = "name";
  static final userProfile = "userProfile";
  static final userId = "userId";
  static final email = "email";
  static final password = "password";
  static final phone = "phone";
  static final plivoPhoneNumber = "plivo_phone_number";
  static final notificationToken = "notification_token";
  static final resendUserId =  "resendUserId";
  static final deviceToken = 'deviceToken';
}

class UserDetails {
  static final token = "token";
  static final userName = "userName";
  static final name = "name";
  static final userProfile = "userProfile";
}

String dummyProfilePic =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s';
String appFont = 'HelveticaNeuea';
List<String> dummyProfilePicList = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFDjXj1F8Ix-rRFgY_r3GerDoQwfiOMXVt-tZdv_Mcou_yIlUC&s',
  'http://www.azembelani.co.za/wp-content/uploads/2016/07/20161014_58006bf6e7079-3.png',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzDG366qY7vXN2yng09wb517WTWqp-oua-mMsAoCadtncPybfQ&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq7BgpG1CwOveQ_gEFgOJASWjgzHAgVfyozkIXk67LzN1jnj9I&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPxjRIYT8pG0zgzKTilbko-MOv8pSnmO63M9FkOvfHoR9FvInm&s',
  'https://cdn5.f-cdn.com/contestentries/753244/11441006/57c152cc68857_thumb900.jpg',
  'https://cdn6.f-cdn.com/contestentries/753244/20994643/57c189b564237_thumb900.jpg'
];

class AppIcon {
  static final int fabTweet = 0xf029;
  static final int messageEmpty = 0xf187;
  static final int messageFill = 0xf554;
  static final int search = 0xf058;
  static final int searchFill = 0xf558;
  static final int notification = 0xf055;
  static final int notificationFill = 0xf019;
  static final int messageFab = 0xf053;
  static final int home = 0xf053;
  static final int homeFill = 0xF553;
  static final int heartEmpty = 0xf148;
  static final int heartFill = 0xf015;
  static final int settings = 0xf059;
  static final int adTheRate = 0xf064;
  static final int reply = 0xf151;
  static final int retweet = 0xf152;
  static final int image = 0xf109;
  static final int camera = 0xf110;
  static final int arrowDown = 0xf196;
  static final int blueTick = 0xf099;

  static final int link = 0xf098;
  static final int unFollow = 0xf097;
  static final int mute = 0xf101;
  static final int viewHidden = 0xf156;
  static final int block = 0xe609;
  static final int report = 0xf038;
  static final int pin = 0xf088;
  static final int delete = 0xf154;

  static final int profile = 0xf056;
  static final int lists = 0xf094;
  static final int bookmark = 0xf155;
  static final int moments = 0xf160;
  static final int twitterAds = 0xf504;
  static final int bulb = 0xf567;
  static final int newMessage = 0xf035;

  static final int sadFace = 0xf430;
  static final int bulbOn = 0xf066;
  static final int bulbOff = 0xf567;
  static final int follow = 0xf175;
  static final int thumbpinFill = 0xf003;
  static final int calender = 0xf203;
  static final int locationPin = 0xf031;
  static final int edit = 0xf112;
}
