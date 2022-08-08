class Post {
  String? uid;
  String? fullName;
  String? imgUser;
  String? id;
  String imgPost;
  String caption;
  String? date;
  bool liked = false;
  bool mine = false;

  Post(
      {required this.imgPost,
        required this.caption,
        this.uid,
        this.fullName,
        this.imgUser,
        this.id,
        this.date});

  Post.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        fullName = json["fullName"],
        imgUser = json["img_user"],
        id = json["id"],
        imgPost = json["img_post"],
        caption = json["caption"],
        date = json["date"],
        liked = json["liked"];

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "fullName": fullName,
    "img_user": imgUser,
    "id": id,
    "img_post": imgPost,
    "caption": caption,
    "date": date,
    "liked": liked
  };
}
