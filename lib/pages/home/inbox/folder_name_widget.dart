import 'package:firebase_login_app/extensions/string_extensions.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/localization/localization_keys.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:flutter/material.dart';

class FolderNameWidget extends StatelessWidget {
  const FolderNameWidget(this.filter, {super.key});

  final Messages filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: const BoxDecoration(),
      child: Text(
        context.localize(filter.toLocKey()).capitalize(),
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
