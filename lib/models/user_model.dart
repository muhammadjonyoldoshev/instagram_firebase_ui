class UserModel {
  String uid = "";
  String fullName;
  String email;
  String password;
  String imgUrl = "";
  String deviceId = "";
  String deviceType = "";
  String deviceToken = "";

  bool followed = false;
  int followers = 0;
  int followings = 0;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        fullName = json["fullName"],
        email = json["email"],
        password = json["password"],
        imgUrl = json["img_url"],
        deviceId = json["device_id"]??"",
        deviceType = json["device_type"]??"",
        deviceToken = json["device_token"]??"";

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "fullName": fullName,
    "email": email,
    "password": password,
    "img_url": imgUrl,
    'device_id': deviceId,
    'device_type': deviceType,
    'device_token': deviceToken,
  };

  @override
  bool operator ==(Object other) {
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => super.hashCode;

}
