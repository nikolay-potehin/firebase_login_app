import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  const UserData({
    required this.email,
    required this.displayName,
    required this.creationTime,
    required this.lastSignInTime,
    this.avatarName,
  });

  final String email;
  final String displayName;
  final String? avatarName;
  final Timestamp creationTime;
  final Timestamp lastSignInTime;

  factory UserData.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;

    return UserData(
      email: json['email'],
      displayName: json['displayName'],
      creationTime: json['creationTime'],
      lastSignInTime: json['lastSignInTime'],
      avatarName: json['avatarName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'creationTime': creationTime,
        'lastSignInTime': lastSignInTime,
        if (avatarName != null) 'avatarName': avatarName,
      };
}
