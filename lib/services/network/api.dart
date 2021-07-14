import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/model/courseLesson_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/courselist_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/searchCourse_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/serachModule_model.dart';
import 'package:farm_system/feature/edit_setup/model/EditProfileModel.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_category_post_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_category_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_subcategory_model.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategory.model.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/postsubcategory.model.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/savesearch.modal.dart';
import 'package:farm_system/feature/feed/comment/modal/comment.modal.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/models/repostFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/modal/repeatFromPost.modal.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/deletecommentmodel.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/nestedreplyview.modal.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/updatedComment.modal.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/model/commentpostreply.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/subcommentfullviewmodel.dart';
import 'package:farm_system/feature/first_screen/repo/DeleteNotificationModel.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationCommentModel.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationModel.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/followModel.dart';
import 'package:farm_system/feature/login/repo/login.model.dart';
import 'package:farm_system/feature/message/models/chatlist.model.dart';
import 'package:farm_system/feature/message/models/conversationlist.model.dart';
import 'package:farm_system/feature/message/models/follows.model.dart';
import 'package:farm_system/feature/message/models/getConversationId.model.dart';
import 'package:farm_system/feature/otp/otp_validation_model.dart';
import 'package:farm_system/feature/profile_setUp/repo/message_model.dart';
import 'package:farm_system/feature/profile_user/model/UserProfileInfoModel.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likesubcategory_model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/PRsubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/PRsubcategory_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubTab.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/userProfileAllData.modal.dart';
import 'package:farm_system/feature/resend_otp/resend_otp_model.dart';
import 'package:farm_system/feature/set_password/set_password_model.dart';
import 'package:farm_system/feature/sign_up/repo/sign_up_model.dart';
import 'package:farm_system/models/sub_category_models.dart';
import 'package:farm_system/screen/Discovery/Model/discovery_search_model.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart';
import 'package:farm_system/screen/Discovery/repo/discovery_search.repo.dart';
import 'package:retrofit/http.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/mediaSubTab.model.dart';

part "api.g.dart";

const String email_header = "email";
const String authorization = "Authorization";
const String userId = "user";

@RestApi(baseUrl: BASE_API_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('farm/login')
  Future<LoginModel> login(@Body() body);

  @POST('farm/register')
  Future<SignUpModel> register(@Body() body);

  @POST('farm/checkOTP')
  Future<OtpValidationModel> varifyOtp(@Body() body);

  @POST('farm/profileSetup')
  Future<MessageModel> selectType(
      @Query("profileSetup") bool profileSetup, @Body() body);

  // @POST('farm/profileSetup')
  // Future<MessageModel> skipNow(@Header(user) user, @Query("profileSetup") bool profileSetup, @Body() body);

  @POST('farm/profileSetup')
  Future<MessageModel> skipNow(
      @Header(userId) user, @Query("profileSetup") bool profileSetup);

  @PUT('farm/finishSignup')
  Future<SetPasswordModel> setPassword(@Body() body);

  @PUT('farm/updateProfileSetup/{userId}')
  Future<MessageModel> uploadProfileTwo(@Path("userId") email, @Body() body);

  @POST('farm/forgotPassword')
  Future<MessageModel> forgotPassword(@Path("email") email, @Body() body);

  @PUT('farm/setNewPassword')
  Future<MessageModel> setNewPassowrdNew(@Body() body);

  @POST('farm/resendOTP')
  Future<ResendOtpModel> resendOTP(@Body() body);

  @POST('farm/profileSetup')
  Future<MessageModel> pS1WihtImageNext(
      @Header(email_header) token, @Body() body);

  @GET('feed/getFeeds/Public')
  Future<FeedPostsModel> getFeedList(@Header(authorization) auth);

  @GET('feed/getFeedById')
  Future<PostDetailsBasedOnId> userdetailsBasedOnId(
      @Header(authorization) auth, @Query("postId") String postId);

  @GET('farm/getProfile')
  Future<UserProfileDetailsBasedOnId> userInfoBasedOnId(
      @Header(authorization) auth, @Query("userId") String userId);

  @POST('farm/follow')
  Future<FollowModel> followOrUnfollow(
      @Header(authorization) auth, @Body() body);

  // @GET('feed/getFeeds/Private')
  // Future<PostDetailsBasedOnId> userdetailsBasedOnId(@Header(authorization) auth, @Query("userId") String userId);

  @POST('feed/likeFeeds')
  Future<MessageModel> likeOrDislike(@Header(authorization) auth,
      @Query("postId") String postId, @Query("unlike") bool unlike);

  @GET('feed/getCategories')
  Future<PostCategory> getCategoryList(@Header(authorization) auth,
      @Query("tags") String tags, @Query("mainCategory") String mainCategory);

  @GET('feed/getCategories')
  Future<SubPostCategory> getSubCategoryList(@Header(authorization) auth,
      @Query("tags") String tags, @Query("mainCategory") String mainCategory);

  @POST('feed/addCategory')
  Future<SaveSearch> postSaveSearch(@Header(authorization) auth, @Body() body);

  @GET('feed/discoverHomePage')
  Future<Disovery> getDiscovery(
    @Header(authorization) auth,
  );

  @GET('feed/discoverSubCategoryPage')
  Future<SubCategoryDiscover> getSubDiscoverCategoryList(
      @Header(authorization) auth, @Query("mainCategory") String mainCategory);

  //For comment API
  @POST('feed/postComment')
  Future<CommentPostDetail> commentPost(
      @Header(authorization) auth, @Body() body);

  //For Reply Post Comment
  @POST('feed/postReply')
  Future<CommentPostReply> commentPostReply(
      @Header(authorization) auth,
      @Query("parentId") String parentId,
      @Query("parentUserId") String parentUserId,
      @Query("grandParentId") String grandParentId,
      @Body() body);

  // @POST('feed/postReply')x
  // @MultiPart()
  // Future<CommentPostReply> commentPostReply(@Header(authorization) auth,@Query("parentId") String parentId,
  //     @Query("parentUserId") String parentUserId,  @Query("grandParentId") String grandParentId, @Part() body,@Part() List<File> file);

  @GET('feed/getReplies')
  Future<CommentPostFullView> getCommentFullView(
      @Header(authorization) auth, @Query("commentId") String commentId);

  @GET('feed/getNestedReplies')
  Future<NestedReplyViews> getNestedReplyView(
      @Header(authorization) auth, @Query("replyId") String replyId);

  //Deleting the postcomment
  @DELETE('feed/deleteComment')
  Future<DeleteComment> deletecomment(
      @Header(authorization) auth, @Query("commentId") String commentId);

  @PUT('feed/updateComment')
  Future<UpdatedComment> updatedComment(@Header(authorization) auth,
      @Query("commentId") String commentId, @Body() body);

  //Edit Profile Page
  @PUT('farm/editUserProfile')
  Future<EditProfile> editProfile(@Header(authorization) auth, @Body() body);

  @POST('feed/RepostFeed')
  Future<RepostFeedModel> repostFeedPost(@Header(authorization) auth,
      @Query("postId") String postId, @Query("Repost") bool Repost);

  @POST('feed/RepeatFeed')
  Future<RepeatFromPost> postRepeatFromPost(
      @Header(authorization) auth, @Body() body);

  @POST('feed/RepostFeed')
  Future<RepostFeedModel> repostSubCommentPost(@Header(authorization) auth,
      @Query("commentId") String postId, @Query("Repost") bool Repost);

  @GET('chat/getConversations')
  Future<ConversationList> getConversations(@Header(authorization) auth,
      @Query("searchKey") String searchKey, @Query("page") int page);

  @GET('chat/getChats')
  Future<ChatList> getChats(
      @Header(authorization) auth,
      @Query("conversationId") String conversationId,
      @Query("pages") int page,
      @Query("userId") String userId);

  @GET('farm/listFollows')
  Future<FollowsList> getMyFollows(
      @Header(authorization) auth,
      @Query("username") String searchKey,
      @Query("following") bool following,
      @Query("followers") bool followers);

  @GET('feed/farmPlusList')
  Future<FarmPlusHome> getFarmPlusCategory(
    @Header(authorization) auth,
  );

  @GET('feed/farmPlusList')
  Future<FarmCategoryPost> getFarmPlusCategoryPost(
      @Header(authorization) auth, @Query("categoryId") String categoryId);

  @GET('feed/farmPlusList')
  Future<FarmSubCategoryList> getFarmPlusSubCategoryPost(
      @Header(authorization) auth,
      @Query("categoryId") String categoryId,
      @Query("subCategory") String subCategory);

  @GET('feed/getRepeatingFeed')
  Future<RepeatPostFullView> getRepeatFullView(
      @Header(authorization) auth, @Query("repeatingId") String repeatingId);

  @GET('farm/listUnFollowsUsers')
  Future<DiscSearch> getDiscoverySearchList(
      @Header(authorization) auth, @Query("searchKey") String searchKey);

  @POST('chat/postConversation')
  Future<GetConversationId> getConversation(
      @Header(authorization) auth, @Body() body);

  @GET('feed/getUserFeeds')
  Future<ProfileUserAll> getUserAllDetails(
      @Header(authorization) auth, @Query("userId") String userId);

  @GET('feed/getCategories')
  Future<ProfileCategoriesDetails> getProfileSubTab(@Header(authorization) auth,
      @Query("tags") String tags, @Query("mainCategory") String mainCategory);

  @GET('feed/getUserFeeds')
  Future<ProfileSubCategoriesDetails> getProfileSubCategoryIndividual(
      @Header(authorization) auth,
      @Query("userId") String userId,
      @Query("categoryId") String categoryId);

  @GET('farmPlus/getFarmCategory')
  Future<FarmPlusCategory> getFarmCategory(
    @Header(authorization) auth,
  );

  @GET('feed/getUserReplies')
  Future<ProfilePostRepliesDetails> getUserReplies(
      @Header(authorization) auth, @Query("userId") String userId);

  @GET('feed/getUserMedia')
  Future<GetUserMedia> getUserMediaAll(
      @Header(authorization) auth, @Query("userId") String userId);

  @PUT('chat/pushNotificationSetting')
  Future<MessageModel> manageNotification(
      @Header(authorization) auth,
      @Query("notificationOn") bool boolType,
      @Query("conversationId") String conversationId);

  @POST('feed/likeFeeds')
  Future<MessageModel> likeOrDislikeComment(@Header(authorization) auth,
      @Query("commentId") String commentId, @Query("unlike") bool unlike);

  @PUT('chat/deleteChats')
  Future<MessageModel> deleteMessages(
      @Header(authorization) auth,
      @Query("chats") String chats,
      @Query("conversationId") String conversationId);

  @GET('feed/getUserLikes')
  Future<GetUserLikes> getUserLikeAll(
      @Header(authorization) auth, @Query("userId") String userId);

//media categories
  @GET('feed/getCategories')
  Future<MediaCategoriesDetails> getMediaSubTab(@Header(authorization) auth,
      @Query("tags") String tags, @Query("mainCategory") String mainCategory);

  @GET('feed/getUserMedia')
  Future<GetUserMedia> getMediaSubCategoryIndividual(
      @Header(authorization) auth,
      @Query("userId") String userId,
      @Query("categoryId") String categoryId);

  //Get Notification
  @GET('notification/getNotifications')
  Future<NotificatinModel> getNotifications(
    @Header(authorization) auth,
  );

  //Clear Notification
  @DELETE('notification/clearNotification')
  Future<ClearNotification> clearNotification(
    @Header(authorization) auth,
  );

  //On/Off Notification
  @PUT('notification/NotificationSetting')
  Future<MessageModel> OnOffNotification(
    @Header(authorization) auth,
    @Query("notificationOn") bool boolType,
  );

  //NotificationComment
  @GET('notification/getCommentById')
  Future<NotificatinComment> getNotificationsComment(
      @Header(authorization) auth, @Query("commentId") String commentId);

  @GET('feed/getCategories')
  Future<LikeCategoriesDetails> getLikeSubTab(@Header(authorization) auth,
      @Query("tags") String tags, @Query("mainCategory") String mainCategory);

  @GET('feed/getUserLikes')
  Future<GetUserCategoryLikes> getLikeSubCategoryIndividual(
      @Header(authorization) auth,
      @Query("userId") String userId,
      @Query("categoryId") String categoryId);

  //PostReply categories
  @GET('feed/getCategories')
  Future<PostReplyCategoriesDetails> getPostReplySubTab(
      @Header(authorization) auth,
      @Query("tags") String tags,
      @Query("mainCategory") String mainCategory);

  @GET('feed/getUserReplies')
  Future<ProfilePostRepliesDetails> getPostReplySubCategoryIndividual(
      @Header(authorization) auth,
      @Query("userId") String userId,
      @Query("categoryId") String categoryId);

  //course listing
  @GET('courses/getCoursesContent')
  Future<GetCourseList> getCourseList(@Header(authorization) auth);

  //course lesson
  @GET('courses/getCoursesContent')
  Future<InsideCorseList> getCourseLessonList(
      @Header(authorization) auth,
      @Query("courseId") String courseId,
      @Query("isCourseslist") bool isCourseslist);

  @GET('courses/getCoursesContent')
  Future<InsideCorseList> getCourseVideoList(
      @Header(authorization) auth,
      @Query("courseId") String courseId,
      @Query("moduleId") String moduleId,
      @Query("isCourseslist") bool isCourseslist);

  //For detaild page of the lesson
  @GET('courses/getSelectedCourseVideo')
  Future<InsideCorseList> getCourseSingleVideo(
      @Header(authorization) auth,
      @Query("courseId") String courseId,
      @Query("moduleId") String moduleId,
      @Query("page") int page);

  //for course serach using the same model coursecontent but api name is diff
  @GET('courses/searchCourse')
  Future<CourseSearch> getSearchCourseList(
      @Header(authorization) auth, @Query("searchKey") String searchKey);

  @GET('courses/searchCourseModules')
  Future<ModuleSearch> getSearchModuleList(
      @Header(authorization) auth,
      @Query("searchKey") String searchKey,
      @Query("pages") int pages,
      @Query("courseId") String courseId,);
}
