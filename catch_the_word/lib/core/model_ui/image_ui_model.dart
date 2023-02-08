class ImageUIModel {
  final String image;
  final String keyword;
  String? messageId;
  String? groupId;
  ImageUIModel({
    required this.image,
    required this.keyword,
    this.messageId,
    this.groupId,
  });

  ImageUIModel.fromJson(Map<String, Object?> json)
      : this(
          image: json['image'] as String,
          keyword: json['keyword'] as String,
        );
  Map<String, Object?> toJson() {
    return {
      'image': image,
      'keyword': keyword,
    };
  }
}
