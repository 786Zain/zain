import 'package:farm_system/dashboard/repo/dash_board_repo.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/repo/courselesson_repo.dart';
import 'package:farm_system/feature/Courses/courses_home/repo/course_search_repo.dart';
import 'package:farm_system/feature/Courses/courses_home/repo/courselist_repo.dart';
import 'package:farm_system/feature/edit_setup/repo/editProfileRepo.dart';
import 'package:farm_system/feature/farm_plus_setup/repo/farm_plus_repo.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/repo/repeatViewRepo.repo.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategory.repo.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/postcategory.repo.dart';
import 'package:farm_system/feature/feed/comment/repo/comment.repo.dart';
import 'package:farm_system/feature/feed/repeat/repo/repeat.repo.dart';
import 'package:farm_system/feature/feed/repeatSubComment/repo/repeatSubComment.repo.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repo/deletecomment.repo.dart';
import 'package:farm_system/feature/first_screen/repo/repo.dart';
import 'package:farm_system/feature/follower_following/followPage_add/AddReop/repo.dart';
import 'package:farm_system/feature/message/repo/message.repo.dart';
import 'package:farm_system/feature/profile_user/repo/profileRepo.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repo/nestedreply.repo.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repo/subcommentfullpage.repo.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/repo/subcommentreply.repo.dart';
import 'package:farm_system/feature/profile_user/view/Likes/repo/like_repo.dart';
import 'package:farm_system/feature/profile_user/view/Likes/repo/likesubtab_reepo.dart';
import 'package:farm_system/feature/profile_user/view/Media/repo/media_Repo.dart';
import 'package:farm_system/feature/profile_user/view/Media/repo/media_subTabRepo.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/PRsubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/repo/postReplies.repo.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/repo/postreplySubTab_repo.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/repo/profileSubCategoryIndividual.repo.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/repo/profileSubTab.repo.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/repo/userProfileAllRepo.repo.dart';
import 'package:farm_system/feature/splash/repo/splash.repo.dart';
import 'package:farm_system/models/sub_category_models.dart';
import 'package:farm_system/post_tweet/repo/post_tweet.repo.dart';
import 'package:farm_system/riverpod/sub_category_repo.dart';
import 'package:farm_system/screen/Discovery/repo/discovery.repo.dart';
import 'package:farm_system/screen/Discovery/repo/discovery_search.repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/repo.dart';

final dashboardProvider = ChangeNotifierProvider<DashboardRepo>((ref) {
  return DashboardRepo();
});

final splashProvider = ChangeNotifierProvider<SplashRepo>((ref) {
  return SplashRepo();
});

final feedProvider = ChangeNotifierProvider<FeedRepo>((ref) {
  return FeedRepo();
});

final profileProvider = ChangeNotifierProvider<ProfileRepo>((ref) {
  return ProfileRepo();
});

final postProvider = ChangeNotifierProvider<PostRepo>((ref) {
  return PostRepo();
});

final postCategoryProvider = ChangeNotifierProvider<PostCategory>((ref) {
  return PostCategory();
});

final subPostCategoryProvider = ChangeNotifierProvider<SubPostCategory>((ref) {
  return SubPostCategory();
});

final saveSearchProvider = ChangeNotifierProvider<SubPostCategory>((ref) {
  return SubPostCategory();
});

final discoveryProvider = ChangeNotifierProvider<DiscoveryRepo>((ref) {
  return DiscoveryRepo();
});

final subCategoryProvider = ChangeNotifierProvider<SubCategoryRepo>((ref) {
  return SubCategoryRepo();
});

final commentProvider = ChangeNotifierProvider<CommentRepo>((ref) {
  return CommentRepo();
});

final subCommentPostProvider =
    ChangeNotifierProvider<SubCommentReplyToPost>((ref) {
  return SubCommentReplyToPost();
});

final subCommentFullPostViewProvider =
    ChangeNotifierProvider<SubCommentFullPageRepo>((ref) {
  return SubCommentFullPageRepo();
});

final nestedProvider = ChangeNotifierProvider<NestedReplyRepo>((ref) {
  return NestedReplyRepo();
});

final deleteCommentProvider = ChangeNotifierProvider<DeleteCommentRepo>((ref) {
  return DeleteCommentRepo();
});

final editProfileProvider = ChangeNotifierProvider<EditProfileRepo>((ref) {
  return EditProfileRepo();
});

final farmPlusProvider = ChangeNotifierProvider<FarmPlusRepo>((ref) {
  return FarmPlusRepo();
});

final repeatFromPostProvider = ChangeNotifierProvider<RepeatRepo>((ref) {
  return RepeatRepo();
});

final repeatSubCommentPostProvider =
    ChangeNotifierProvider<RepeatSubCommentRepo>((ref) {
  return RepeatSubCommentRepo();
});

final messageProvider = ChangeNotifierProvider<MessageRepo>((ref) {
  return MessageRepo();
});

final profileFollow = ChangeNotifierProvider<ProfileFollowRepo>((ref) {
  return ProfileFollowRepo();
});

// final profileFollow = ChangeNotifierProvider<ProfileFollowRepo>((ref)) {
// return ProfileFollowRepo();
// });

final repeatPostProvider = ChangeNotifierProvider<RepeatPostView>((ref) {
  return RepeatPostView();
});

final discoverySearchprovider =
    ChangeNotifierProvider<DiscoverySearchRepo>((ref) {
  return DiscoverySearchRepo();
});

final courseSearchprovider =
ChangeNotifierProvider<CourseSearchRepo>((ref) {
  return CourseSearchRepo();
});

final userAllProvider = ChangeNotifierProvider<UserProfileAllDetails>((ref) {
  return UserProfileAllDetails();
});

final userMedia = ChangeNotifierProvider<MediaDetails>((ref) {
  return MediaDetails();
});
final addSearchprovider = ChangeNotifierProvider<AddSearchRepo>((ref) {
  return AddSearchRepo();
});

final profileSubTabProvider = ChangeNotifierProvider<ProfileSubTab>((ref) {
  return ProfileSubTab();
});

final profileSubCategoryIndividualProvider = ChangeNotifierProvider<ProfileSubCategoryIndividual>((ref) {
  return ProfileSubCategoryIndividual();
});

final postRepliesProvider = ChangeNotifierProvider<PostRepliesProfileRepo>((ref) {
  return PostRepliesProfileRepo();
});

final userLikes = ChangeNotifierProvider<LikeDetails>((ref) {
  return LikeDetails();
});

final notificationList = ChangeNotifierProvider<NotificationRepo>((ref) {
  return NotificationRepo();
});

//media category
final mediaSubTabProvider = ChangeNotifierProvider<MediaSubTab>((ref) {
  return MediaSubTab();
});

//like category
final LikeSubTabProvider = ChangeNotifierProvider<LikeSubTabCategory>((ref) {
  return LikeSubTabCategory();
});

//postreplies category
final PostReplySubTabProvider = ChangeNotifierProvider<PostReplySubTabrepo>((ref) {
  return PostReplySubTabrepo();
});

//course list
final courseListRepoProvider = ChangeNotifierProvider<CourseListRepo>((ref) {
  return CourseListRepo();
});
//course lesson
final courseLessonRepoProvider = ChangeNotifierProvider<CourseLessonRepo>((ref) {
  return CourseLessonRepo();
});
