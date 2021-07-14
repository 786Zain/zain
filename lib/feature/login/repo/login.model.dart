//// To parse this JSON data, do
////
////     final loginModel = loginModelFromJson(jsonString);
//
//import 'dart:convert';
//
//LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
//
//String loginModelToJson(LoginModel data) => json.encode(data.toJson());
//
//class LoginModel {
//  LoginModel({
//    this.message,
//    this.user,
//    this.token,
//  });
//
//  String message;
//  User user;
//  String token;
//
//  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//    message: json["message"],
//    user: User.fromJson(json["user"]),
//    token: json["token"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "message": message,
//    "user": user.toJson(),
//    "token": token,
//  };
//}
//
//class User {
//  User({
//    this.profilePic,
//    this.bookmarks,
//    this.id,
//    this.name,
//    this.email,
//    this.birthDate,
//    this.createdAt,
//    this.password,
//    this.otp,
//    this.v,
//    this.category,
//    this.userName,
//    this.profileSetup,
//    this.bio,
//    this.city,
//    this.state,
//    this.website,
//  });
//
//  List<ProfilePic> profilePic;
//  List<dynamic> bookmarks;
//  String id;
//  String name;
//  String email;
//  String birthDate;
//  DateTime createdAt;
//  String password;
//  int otp;
//  int v;
//  String category;
//  String userName;
//  bool profileSetup;
//  String bio;
//  String city;
//  String state;
//  String website;
//
//  factory User.fromJson(Map<String, dynamic> json) => User(
//    profilePic: List<ProfilePic>.from(json["profilePic"].map((x) => ProfilePic.fromJson(x))),
//    bookmarks: List<dynamic>.from(json["bookmarks"].map((x) => x)),
//    id: json["_id"],
//    name: json["name"],
//    email: json["email"],
//    birthDate: json["birthDate"],
//    createdAt: DateTime.parse(json["createdAt"]),
//    password: json["password"],
//    otp: json["otp"],
//    v: json["__v"],
//    category: json["category"],
//    userName: json["userName"],
//    profileSetup: json["profileSetup"],
//    bio: json["bio"],
//    city: json["city"],
//    state: json["state"],
//    website: json["website"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "profilePic": List<dynamic>.from(profilePic.map((x) => x.toJson())),
//    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
//    "_id": id,
//    "name": name,
//    "email": email,
//    "birthDate": birthDate,
//    "createdAt": createdAt.toIso8601String(),
//    "password": password,
//    "otp": otp,
//    "__v": v,
//    "category": category,
//    "userName": userName,
//    "profileSetup": profileSetup,
//    "bio": bio,
//    "city": city,
//    "state": state,
//    "website": website,
//  };
//}
//
//class ProfilePic {
//  ProfilePic({
//    this.fieldname,
//    this.originalname,
//    this.encoding,
//    this.mimetype,
//    this.size,
//    this.bucket,
//    this.key,
//    this.acl,
//    this.contentType,
//    this.contentDisposition,
//    this.storageClass,
//    this.serverSideEncryption,
//    this.metadata,
//    this.location,
//    this.etag,
//    this.versionId,
//  });
//
//  String fieldname;
//  String originalname;
//  String encoding;
//  String mimetype;
//  int size;
//  String bucket;
//  String key;
//  String acl;
//  String contentType;
//  dynamic contentDisposition;
//  String storageClass;
//  dynamic serverSideEncryption;
//  dynamic metadata;
//  String location;
//  String etag;
//  dynamic versionId;
//
//  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
//    fieldname: json["fieldname"],
//    originalname: json["originalname"],
//    encoding: json["encoding"],
//    mimetype: json["mimetype"],
//    size: json["size"],
//    bucket: json["bucket"],
//    key: json["key"],
//    acl: json["acl"],
//    contentType: json["contentType"],
//    contentDisposition: json["contentDisposition"],
//    storageClass: json["storageClass"],
//    serverSideEncryption: json["serverSideEncryption"],
//    metadata: json["metadata"],
//    location: json["location"],
//    etag: json["etag"],
//    versionId: json["versionId"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "fieldname": fieldname,
//    "originalname": originalname,
//    "encoding": encoding,
//    "mimetype": mimetype,
//    "size": size,
//    "bucket": bucket,
//    "key": key,
//    "acl": acl,
//    "contentType": contentType,
//    "contentDisposition": contentDisposition,
//    "storageClass": storageClass,
//    "serverSideEncryption": serverSideEncryption,
//    "metadata": metadata,
//    "location": location,
//    "etag": etag,
//    "versionId": versionId,
//  };
//}


// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.user,
    this.token,
  });

  String message;
  User user;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.profilePic,
    this.bookmarks,
    this.id,
    this.name,
    this.email,
    this.birthDate,
    this.createdAt,
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
  List<dynamic> bookmarks;
  String id;
  String name;
  String email;
  String birthDate;
  DateTime createdAt;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    profilePic: List<ProfilePic>.from(json["profilePic"].map((x) => ProfilePic.fromJson(x))),
    bookmarks: List<dynamic>.from(json["bookmarks"].map((x) => x)),
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    birthDate: json["birthDate"],
    createdAt: DateTime.parse(json["createdAt"]),
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
    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
    "_id": id,
    "name": name,
    "email": email,
    "birthDate": birthDate,
    "createdAt": createdAt.toIso8601String(),
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
