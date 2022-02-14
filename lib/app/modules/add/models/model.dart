class AddLinkModel {
  String? title;
  String? url;
  bool? isFavorite;
  bool? isPrivate;

  AddLinkModel(
      {required this.title,
      required this.url,
      required this.isFavorite,
      required this.isPrivate});
  AddLinkModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    isFavorite = json['isFavorite'];
    isPrivate = json['isPrivate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'time': DateTime.now(),
      'isPrivate': isPrivate,
      'isFavorite': isFavorite,
    };
  }
}
