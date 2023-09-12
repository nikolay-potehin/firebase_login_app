import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/users/users_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localize(LocKeys.users)),
            actions: [
              IconButton(
                onPressed: () async => showSearch(
                  context: context,
                  delegate: UsersSearchDelegate(users: model.users),
                ),
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: Center(child: UsersView(users: model.users)),
        );
      },
    );
  }
}

class UsersSearchDelegate extends SearchDelegate {
  final List<DocumentSnapshot<Map<String, dynamic>>>? users;

  UsersSearchDelegate({required this.users});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final resultUsers = UsersModel.findByQueryIn(users, query);
    return UsersView(users: resultUsers);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedUsers = UsersModel.findByQueryIn(users, query);
    return UsersView(users: suggestedUsers);
  }
}
