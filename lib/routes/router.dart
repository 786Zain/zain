import 'package:auto_route/auto_route_annotations.dart';
import 'package:farm_system/camera/camera.dart';
import 'package:farm_system/camera/camera_form_gallery_view.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/farm_post/custom_gallery.dart';
import 'package:farm_system/feature/farm_post/farm_post.dart';
import 'package:farm_system/feature/first_screen/view/first_screen.dart';
import 'package:farm_system/feature/forgetPassword/forgetPasword_email_screen.dart';
import 'package:farm_system/feature/login/login.dart';
import 'package:farm_system/feature/otp/forget_password_otp_screen.dart';
import 'package:farm_system/feature/otp/otp.dart';
import 'package:farm_system/feature/profile_setUp/profile_setup_page1.dart';
import 'package:farm_system/feature/profile_setUp/profile_setup_page2.dart';
import 'package:farm_system/feature/set_password/set_password.dart';
import 'package:farm_system/feature/sign_up/sign_up.dart';
import 'package:farm_system/feature/splash/splash.dart';
import 'package:farm_system/feature/user_name_password/user_name_password.dart';
import 'package:farm_system/post_tweet/post_tweet.dart';
import 'package:farm_system/update_password/update_password.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: FirstScreen),
  MaterialRoute(page: LoginPage),
  MaterialRoute(page: SignUpPage),
  MaterialRoute(page: ForgetPasswordEmailScreen),
  MaterialRoute(page: Otp),
  MaterialRoute(page: PostTweetPage),
  MaterialRoute(page: UpdatePasswordScreen),
  MaterialRoute(page: CameraExampleHome),
  MaterialRoute(page: Video),
  MaterialRoute(page: ForgetPasswordOTPScreen),
  MaterialRoute(page: SetPasswordScreen),
  MaterialRoute(page: UserNamePassword),
  MaterialRoute(page: ProfileSetupPage1),
  MaterialRoute(page: ProfileSetupPage2),
  MaterialRoute(page: DashBoard),
  MaterialRoute(page: DisplayPictureScreen1),
  MaterialRoute(page: CustomGallery),
  MaterialRoute(page: FarmPost),

])
class $Router {}