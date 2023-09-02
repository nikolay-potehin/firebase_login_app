import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtensions on Timestamp {
  String toTimeString() {
    final timeData = toDate().toString().split(' ');
    final date = timeData[0].split('-').reversed.join('.');
    final time = timeData[1].split('.')[0].substring(0, 5);

    return '$date, $time';
  }

  String toShortTimeString() {
    final dateTime = toDate();
    if (dateTime.day == DateTime.now().day) {
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$hour:$minute';
    }
    return '${dateTime.day} ${_months[dateTime.month]}.';
  }

  static final List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
}
