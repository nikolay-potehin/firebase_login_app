import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtensions on Timestamp {
  String toTimeString() {
    final timeData = toDate().toString().split(' ');
    final date = timeData[0].split('-').reversed.join('.');
    final time = timeData[1].split('.')[0].substring(0, 5);

    return '$date, $time';
  }
}
