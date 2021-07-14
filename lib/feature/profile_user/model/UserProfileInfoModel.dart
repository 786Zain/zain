// // To parse this JSON data, do
// //
// //     final userProfileDetailsBasedOnId = userProfileDetailsBasedOnIdFromJson(jsonString);
//
// import 'dart:convert';
//
// UserProfileDetailsBasedOnId userProfileDetailsBasedOnIdFromJson(String str) => UserProfileDetailsBasedOnId.fromJson(json.decode(str));
//
// String userProfileDetailsBasedOnIdToJson(UserProfileDetailsBasedOnId data) => json.encode(data.toJson());
//
// class UserProfileDetailsBasedOnId {
//   UserProfileDetailsBasedOnId({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   Data data;
//
//   factory UserProfileDetailsBasedOnId.fromJson(Map<String, dynamic> json) => UserProfileDetailsBasedOnId(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.profilePic,
//     this.following,
//     this.followers,
//     this.bookmarks,
//     this.role,
//     this.id,
//     this.name,
//     this.email,
//     this.birthDate,
//     this.createdAt,
//     this.password,
//     this.otp,
//     this.v,
//     this.category,
//     this.userName,
//     this.profileSetup,
//     this.bio,
//     this.city,
//     this.state,
//     this.website,
//     this.lastLoggedIn,
//   });
//
//
//   List<ProfilePic> profilePic;
//   List<dynamic> following;
//   List<dynamic> followers;
//   List<dynamic> bookmarks;
//   String role;
//   String id;
//   String name;
//   String email;
//   String birthDate;
//   DateTime createdAt;
//   String password;
//   int otp;
//   int v;
//   String category;
//   String userName;
//   bool profileSetup;
//   String bio;
//   String city;
//   String state;
//   String website;
//   DateTime lastLoggedIn;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     profilePic: List<ProfilePic>.from(json["profilePic"].map((x) => ProfilePic.fromJson(x))),
//     following: List<dynamic>.from(json["following"].map((x) => x)),
//     followers: List<dynamic>.from(json["followers"].map((x) => x)),
//     bookmarks: List<dynamic>.from(json["bookmarks"].map((x) => x)),
//     role: json["role"],
//     id: json["_id"],
//     name: json["name"],
//     email: json["email"],
//     birthDate: json["birthDate"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     password: json["password"],
//     otp: json["otp"],
//     v: json["__v"],
//     category: json["category"],
//     userName: json["userName"],
//     profileSetup: json["profileSetup"],
//     bio: json["bio"],
//     city: json["city"],
//     state: json["state"],
//     website: json["website"],
//     lastLoggedIn: DateTime.parse(json["lastLoggedIn"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "profilePic": List<dynamic>.from(profilePic.map((x) => x.toJson())),
//     "following": List<dynamic>.from(following.map((x) => x)),
//     "followers": List<dynamic>.from(followers.map((x) => x)),
//     "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
//     "role": role,
//     "_id": id,
//     "name": name,
//     "email": email,
//     "birthDate": birthDate,
//     "createdAt": createdAt.toIso8601String(),
//     "password": password,
//     "otp": otp,
//     "__v": v,
//     "category": category,
//     "userName": userName,
//     "profileSetup": profileSetup,
//     "bio": bio,
//     "city": city,
//     "state": state,
//     "website": website,
//     "lastLoggedIn": lastLoggedIn.toIso8601String(),
//   };
// }
//
// class ProfilePic {
//   ProfilePic({
//     this.fieldname,
//     this.originalname,
//     this.encoding,
//     this.mimetype,
//     this.size,
//     this.bucket,
//     this.key,
//     this.acl,
//     this.contentType,
//     this.contentDisposition,
//     this.storageClass,
//     this.serverSideEncryption,
//     this.metadata,
//     this.location,
//     this.etag,
//     this.versionId,
//   });
//
//   String fieldname;
//   String originalname;
//   String encoding;
//   String mimetype;
//   int size;
//   String bucket;
//   String key;
//   String acl;
//   String contentType;
//   dynamic contentDisposition;
//   String storageClass;
//   dynamic serverSideEncryption;
//   dynamic metadata;
//   String location;
//   String etag;
//   dynamic versionId;
//
//   factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
//     fieldname: json["fieldname"],
//     originalname: json["originalname"],
//     encoding: json["encoding"],
//     mimetype: json["mimetype"],
//     size: json["size"],
//     bucket: json["bucket"],
//     key: json["key"],
//     acl: json["acl"],
//     contentType: json["contentType"],
//     contentDisposition: json["contentDisposition"],
//     storageClass: json["storageClass"],
//     serverSideEncryption: json["serverSideEncryption"],
//     metadata: json["metadata"],
//     location: json["location"],
//     etag: json["etag"],
//     versionId: json["versionId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fieldname": fieldname,
//     "originalname": originalname,
//     "encoding": encoding,
//     "mimetype": mimetype,
//     "size": size,
//     "bucket": bucket,
//     "key": key,
//     "acl": acl,
//     "contentType": contentType,
//     "contentDisposition": contentDisposition,
//     "storageClass": storageClass,
//     "serverSideEncryption": serverSideEncryption,
//     "metadata": metadata,
//     "location": location,
//     "etag": etag,
//     "versionId": versionId,
//   };
// }

// To parse this JSON data, do
//
//     final userProfileDetailsBasedOnId = userProfileDetailsBasedOnIdFromJson(jsonString);



import 'dart:convert';

UserProfileDetailsBasedOnId userProfileDetailsBasedOnIdFromJson(String str) => UserProfileDetailsBasedOnId.fromJson(json.decode(str));

String userProfileDetailsBasedOnIdToJson(UserProfileDetailsBasedOnId data) => json.encode(data.toJson());

class UserProfileDetailsBasedOnId {
  UserProfileDetailsBasedOnId({
    this.message,
    this.data,
    this.isFollowing,
  });

  String message;
  Data data;
  bool isFollowing;

  factory UserProfileDetailsBasedOnId.fromJson(Map<String, dynamic> json) => UserProfileDetailsBasedOnId(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    isFollowing: json["isFollowing"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "isFollowing": isFollowing,
  };
}

class Data {
  Data({
    this.profilePic,
    this.following,
    this.followers,
    this.bookmarks,
    this.isNotificationsEnabled,
    this.role,
    this.id,
    this.name,
    this.email,
    this.birthDate,
    this.createdAt,
    this.lastLoggedIn,
    this.password,
    this.otp,
    this.v,
    this.category,
    this.userName,
    this.profileSetup,
    this.bio,
    this.city,
    this.state,
    this.website,
  });

  List<ProfilePic> profilePic;
  List<dynamic> following;
  List<String> followers;
  List<dynamic> bookmarks;
  bool isNotificationsEnabled;
  String role;
  String id;
  String name;
  String email;
  String birthDate;
  DateTime createdAt;
  DateTime lastLoggedIn;
  String password;
  int otp;
  int v;
  String category;
  String userName;
  bool profileSetup;
  String bio;
  String city;
  String state;
  String website;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profilePic: List<ProfilePic>.from(json["profilePic"].map((x) => ProfilePic.fromJson(x))),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    followers: List<String>.from(json["followers"].map((x) => x)),
    bookmarks: List<dynamic>.from(json["bookmarks"].map((x) => x)),
    isNotificationsEnabled: json["isNotificationsEnabled"],
    role: json["role"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    birthDate: json["birthDate"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastLoggedIn: DateTime.parse(json["lastLoggedIn"]),
    password: json["password"],
    otp: json["otp"],
    v: json["__v"],
    category: json["category"],
    userName: json["userName"],
    profileSetup: json["profileSetup"],
    bio: json["bio"],
    city: json["city"],
    state: json["state"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": List<dynamic>.from(profilePic.map((x) => x.toJson())),
    "following": List<dynamic>.from(following.map((x) => x)),
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
    "isNotificationsEnabled": isNotificationsEnabled,
    "role": role,
    "_id": id,
    "name": name,
    "email": email,
    "birthDate": birthDate,
    "createdAt": createdAt.toIso8601String(),
    "lastLoggedIn": lastLoggedIn.toIso8601String(),
    "password": password,
    "otp": otp,
    "__v": v,
    "category": category,
    "userName": userName,
    "profileSetup": profileSetup,
    "bio": bio,
    "city": city,
    "state": state,
    "website": website,
  };
}

class ProfilePic {
  ProfilePic({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.size,
    this.bucket,
    this.key,
    this.acl,
    this.contentType,
    this.contentDisposition,
    this.storageClass,
    this.serverSideEncryption,
    this.metadata,
    this.location,
    this.etag,
    this.versionId,
  });

  String fieldname;
  String originalname;
  String encoding;
  String mimetype;
  int size;
  String bucket;
  String key;
  String acl;
  String contentType;
  dynamic contentDisposition;
  String storageClass;
  dynamic serverSideEncryption;
  dynamic metadata;
  String location;
  String etag;
  dynamic versionId;

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
    fieldname: json["fieldname"],
    originalname: json["originalname"],
    encoding: json["encoding"],
    mimetype: json["mimetype"],
    size: json["size"],
    bucket: json["bucket"],
    key: json["key"],
    acl: json["acl"],
    contentType: json["contentType"],
    contentDisposition: json["contentDisposition"],
    storageClass: json["storageClass"],
    serverSideEncryption: json["serverSideEncryption"],
    metadata: json["metadata"],
    location: json["location"],
    etag: json["etag"],
    versionId: json["versionId"],
  );

  Map<String, dynamic> toJson() => {
    "fieldname": fieldname,
    "originalname": originalname,
    "encoding": encoding,
    "mimetype": mimetype,
    "size": size,
    "bucket": bucket,
    "key": key,
    "acl": acl,
    "contentType": contentType,
    "contentDisposition": contentDisposition,
    "storageClass": storageClass,
    "serverSideEncryption": serverSideEncryption,
    "metadata": metadata,
    "location": location,
    "etag": etag,
    "versionId": versionId,
  };
}

