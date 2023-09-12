import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:flutter/material.dart';

extension TimestampExtensions on Timestamp {
  String toTimeString() {
    final timeData = toDate().toString().split(' ');
    final date = timeData[0].split('-').reversed.join('.');
    final time = timeData[1].split('.')[0].substring(0, 5);

    return '$date, $time';
  }

  String toShortTimeString(BuildContext context) {
    final dateTime = toDate();
    if (dateTime.day == DateTime.now().day) {
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$hour:$minute';
    }
    return '${dateTime.day} ${context.localize(_months[dateTime.month - 1])}.';
  }

  static final List<LocKeys> _months = [
    LocKeys.monthJan,
    LocKeys.monthFeb,
    LocKeys.monthMar,
    LocKeys.monthApr,
    LocKeys.monthMay,
    LocKeys.monthJun,
    LocKeys.monthJul,
    LocKeys.monthAug,
    LocKeys.monthSep,
    LocKeys.monthOct,
    LocKeys.monthNov,
    LocKeys.monthDec,
  ];
}
