class UserModelUI {
  final String id;
  final String name;
  final String phoneNumber;
  final String birth;
  UserModelUI(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.birth});

  UserModelUI.fromJson(Map<String, Object?> json)
      : this(
          id: json['userId']! as String,
          name: json['name']! as String,
          phoneNumber: json['phoneNumber']! as String,
          birth: json['birth']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'birth': birth,
    };
  }
}
