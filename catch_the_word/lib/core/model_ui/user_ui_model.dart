class UserModelUI {
  final String id;
  final String name;
  final String photoUrl;
  final String createdAt;
  UserModelUI(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.createdAt});

  UserModelUI.fromJson(Map<String, Object?> json)
      : this(
          id: json['uid']! as String,
          name: json['name']! as String,
          photoUrl: json['photoUrl']! as String,
          createdAt: json['createdAt']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'uid': id,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
