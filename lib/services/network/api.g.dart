// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://161.35.118.126/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<LoginModel> login(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('farm/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SignUpModel> register(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('farm/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SignUpModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<OtpValidationModel> varifyOtp(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('farm/checkOTP',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OtpValidationModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> selectType(profileSetup, body) async {
    ArgumentError.checkNotNull(profileSetup, 'profileSetup');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'profileSetup': profileSetup};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/profileSetup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> skipNow(user, profileSetup) async {
    ArgumentError.checkNotNull(user, 'user');
    ArgumentError.checkNotNull(profileSetup, 'profileSetup');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'profileSetup': profileSetup};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/profileSetup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'user': user},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SetPasswordModel> setPassword(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/finishSignup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SetPasswordModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> uploadProfileTwo(email, body) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/updateProfileSetup/$email',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> forgotPassword(email, body) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/forgotPassword',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> setNewPassowrdNew(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/setNewPassword',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResendOtpModel> resendOTP(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('farm/resendOTP',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResendOtpModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> pS1WihtImageNext(token, body) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/profileSetup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'email': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<FeedPostsModel> getFeedList(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getFeeds/Public',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FeedPostsModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostDetailsBasedOnId> userdetailsBasedOnId(auth, postId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(postId, 'postId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'postId': postId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('feed/getFeedById',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PostDetailsBasedOnId.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserProfileDetailsBasedOnId> userInfoBasedOnId(auth, userId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('farm/getProfile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserProfileDetailsBasedOnId.fromJson(_result.data);
    return value;
  }

  @override
  Future<FollowModel> followOrUnfollow(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('farm/follow',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FollowModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> likeOrDislike(auth, postId, unlike) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(postId, 'postId');
    ArgumentError.checkNotNull(unlike, 'unlike');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'postId': postId,
      r'unlike': unlike
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('feed/likeFeeds',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostCategory> getCategoryList(auth, tags, mainCategory) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(tags, 'tags');
    ArgumentError.checkNotNull(mainCategory, 'mainCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tags': tags,
      r'mainCategory': mainCategory
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getCategories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PostCategory.fromJson(_result.data);
    return value;
  }

  @override
  Future<SubPostCategory> getSubCategoryList(auth, tags, mainCategory) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(tags, 'tags');
    ArgumentError.checkNotNull(mainCategory, 'mainCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tags': tags,
      r'mainCategory': mainCategory
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getCategories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SubPostCategory.fromJson(_result.data);
    return value;
  }

  @override
  Future<SaveSearch> postSaveSearch(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('feed/addCategory',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SaveSearch.fromJson(_result.data);
    return value;
  }

  @override
  Future<Disovery> getDiscovery(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/discoverHomePage',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Disovery.fromJson(_result.data);
    return value;
  }

  @override
  Future<SubCategoryDiscover> getSubDiscoverCategoryList(
      auth, mainCategory) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(mainCategory, 'mainCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mainCategory': mainCategory};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/discoverSubCategoryPage',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SubCategoryDiscover.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommentPostDetail> commentPost(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('feed/postComment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommentPostDetail.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommentPostReply> commentPostReply(
      auth, parentId, parentUserId, grandParentId, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(parentId, 'parentId');
    ArgumentError.checkNotNull(parentUserId, 'parentUserId');
    ArgumentError.checkNotNull(grandParentId, 'grandParentId');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'parentId': parentId,
      r'parentUserId': parentUserId,
      r'grandParentId': grandParentId
    };
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('feed/postReply',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommentPostReply.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommentPostFullView> getCommentFullView(auth, commentId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(commentId, 'commentId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'commentId': commentId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('feed/getReplies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommentPostFullView.fromJson(_result.data);
    return value;
  }

  @override
  Future<NestedReplyViews> getNestedReplyView(auth, replyId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(replyId, 'replyId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'replyId': replyId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getNestedReplies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NestedReplyViews.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteComment> deletecomment(auth, commentId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(commentId, 'commentId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'commentId': commentId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/deleteComment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteComment.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdatedComment> updatedComment(auth, commentId, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(commentId, 'commentId');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'commentId': commentId};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/updateComment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdatedComment.fromJson(_result.data);
    return value;
  }

  @override
  Future<EditProfile> editProfile(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/editUserProfile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EditProfile.fromJson(_result.data);
    return value;
  }

  @override
  Future<RepostFeedModel> repostFeedPost(auth, postId, Repost) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(postId, 'postId');
    ArgumentError.checkNotNull(Repost, 'Repost');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'postId': postId,
      r'Repost': Repost
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('feed/RepostFeed',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RepostFeedModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<RepeatFromPost> postRepeatFromPost(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>('feed/RepeatFeed',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RepeatFromPost.fromJson(_result.data);
    return value;
  }

  @override
  Future<RepostFeedModel> repostSubCommentPost(auth, postId, Repost) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(postId, 'postId');
    ArgumentError.checkNotNull(Repost, 'Repost');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'commentId': postId,
      r'Repost': Repost
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('feed/RepostFeed',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RepostFeedModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ConversationList> getConversations(auth, searchKey, page) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(searchKey, 'searchKey');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'searchKey': searchKey,
      r'page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'chat/getConversations',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ConversationList.fromJson(_result.data);
    return value;
  }

  @override
  Future<ChatList> getChats(auth, conversationId, page, userId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(conversationId, 'conversationId');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'conversationId': conversationId,
      r'pages': page,
      r'userId': userId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('chat/getChats',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ChatList.fromJson(_result.data);
    return value;
  }

  @override
  Future<FollowsList> getMyFollows(
      auth, searchKey, following, followers) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(searchKey, 'searchKey');
    ArgumentError.checkNotNull(following, 'following');
    ArgumentError.checkNotNull(followers, 'followers');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': searchKey,
      r'following': following,
      r'followers': followers
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('farm/listFollows',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FollowsList.fromJson(_result.data);
    return value;
  }

  @override
  Future<FarmPlusHome> getFarmPlusCategory(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/farmPlusList',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FarmPlusHome.fromJson(_result.data);
    return value;
  }

  @override
  Future<FarmCategoryPost> getFarmPlusCategoryPost(auth, categoryId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'categoryId': categoryId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/farmPlusList',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FarmCategoryPost.fromJson(_result.data);
    return value;
  }

  @override
  Future<FarmSubCategoryList> getFarmPlusSubCategoryPost(
      auth, categoryId, subCategory) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    ArgumentError.checkNotNull(subCategory, 'subCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'categoryId': categoryId,
      r'subCategory': subCategory
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/farmPlusList',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FarmSubCategoryList.fromJson(_result.data);
    return value;
  }

  @override
  Future<RepeatPostFullView> getRepeatFullView(auth, repeatingId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(repeatingId, 'repeatingId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'repeatingId': repeatingId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getRepeatingFeed',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RepeatPostFullView.fromJson(_result.data);
    return value;
  }

  @override
  Future<DiscSearch> getDiscoverySearchList(auth, searchKey) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(searchKey, 'searchKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchKey': searchKey};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'farm/listUnFollowsUsers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DiscSearch.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetConversationId> getConversation(auth, body) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.request<Map<String, dynamic>>(
        'chat/postConversation',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetConversationId.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProfileUserAll> getUserAllDetails(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getUserFeeds',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProfileUserAll.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProfileCategoriesDetails> getProfileSubTab(
      auth, tags, mainCategory) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(tags, 'tags');
    ArgumentError.checkNotNull(mainCategory, 'mainCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tags': tags,
      r'mainCategory': mainCategory
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getCategories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProfileCategoriesDetails.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProfileSubCategoriesDetails> getProfileSubCategoryIndividual(
      auth, categoryId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'categoryId': categoryId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getUserFeeds',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProfileSubCategoriesDetails.fromJson(_result.data);
    return value;
  }

  @override
  Future<FarmPlusCategory> getFarmCategory(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'farmPlus/getFarmCategory',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FarmPlusCategory.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProfilePostRepliesDetails> getUserReplies(auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'feed/getUserReplies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProfilePostRepliesDetails.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageModel> manageNotification(
      auth, boolType, conversationId) async {
    ArgumentError.checkNotNull(auth, 'auth');
    ArgumentError.checkNotNull(boolType, 'boolType');
    ArgumentError.checkNotNull(conversationId, 'conversationId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'notificationOn': boolType,
      r'conversationId': conversationId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'chat/pushNotificationSetting',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': auth},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageModel.fromJson(_result.data);
    return value;
  }
}
