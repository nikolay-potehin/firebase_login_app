import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  const UserData({
    required this.email,
    required this.displayName,
    required this.creationTime,
    required this.lastSignInTime,
    required this.isEmailVerified,
    this.avatarName,
  });

  final String email;
  final String displayName;
  final String? avatarName;
  final Timestamp creationTime;
  final Timestamp lastSignInTime;
  final bool isEmailVerified;

  factory UserData.fromDocument(
          DocumentSnapshot<Map<String, dynamic>> document) =>
      UserData.fromJson(document.data()!);

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json['email'],
        displayName: json['displayName'],
        creationTime: json['creationTime'],
        lastSignInTime: json['lastSignInTime'],
        isEmailVerified: json['isEmailVerified'] ?? false,
        avatarName: json['avatarName'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'creationTime': creationTime,
        'lastSignInTime': lastSignInTime,
        'isEmailVerified': isEmailVerified,
        if (avatarName != null) 'avatarName': avatarName,
      };
}
