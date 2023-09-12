import 'package:firebase_login_app/extensions/string_extensions.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/localization/localization_keys.dart';
import 'package:firebase_login_app/models/inbox_model.dart';
import 'package:flutter/material.dart';

class EmptyInboxWidget extends StatelessWidget {
  const EmptyInboxWidget({
    super.key,
    required this.filter,
  });

  final Messages filter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.drafts_outlined,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              '${context.localize(LocKeys.yourFolderIs)}'
              ' "${context.localize(filter.toLocKey()).capitalize()}" '
              '${context.localize(LocKeys.folderIsEmpty)}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
