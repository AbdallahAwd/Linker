class UserModel {
  String? email;
  String? userName;
  String? image;
  String? uid;

  UserModel(
      {required this.email,
      required this.image,
      required this.userName,
      required this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    image = json['image'];
    uid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'image': image,
      'uid': uid,
    };
  }
}
