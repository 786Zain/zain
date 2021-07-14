class ProfilePicUpdateModel {
  String message;
  FileUrl fileUrl;

  ProfilePicUpdateModel({this.message, this.fileUrl});

  ProfilePicUpdateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fileUrl =
        json['fileUrl'] != null ? new FileUrl.fromJson(json['fileUrl']) : "xxx";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.fileUrl != null) {
      data['fileUrl'] = this.fileUrl.toJson();
    }
    return data;
  }
}

class FileUrl {
  String fieldname;
  String originalname;
  String encoding;
  String mimetype;
  int size;
  String bucket;
  String key;
  String acl;
  String contentType;
  Null contentDisposition;
  String storageClass;
  Null serverSideEncryption;
  Null metadata;
  String location;
  String etag;

  FileUrl(
      {this.fieldname,
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
      this.etag});

  FileUrl.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    size = json['size'];
    bucket = json['bucket'];
    key = json['key'];
    acl = json['acl'];
    contentType = json['contentType'];
    contentDisposition = json['contentDisposition'];
    storageClass = json['storageClass'];
    serverSideEncryption = json['serverSideEncryption'];
    metadata = json['metadata'];
    location = json['location'];
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['encoding'] = this.encoding;
    data['mimetype'] = this.mimetype;
    data['size'] = this.size;
    data['bucket'] = this.bucket;
    data['key'] = this.key;
    data['acl'] = this.acl;
    data['contentType'] = this.contentType;
    data['contentDisposition'] = this.contentDisposition;
    data['storageClass'] = this.storageClass;
    data['serverSideEncryption'] = this.serverSideEncryption;
    data['metadata'] = this.metadata;
    data['location'] = this.location;
    data['etag'] = this.etag;
    return data;
  }
}