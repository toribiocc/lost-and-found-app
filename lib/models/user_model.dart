class UserModel {
  final String uid;
  final String username;
  final String email;
  final String avatarUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': username,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }
}
