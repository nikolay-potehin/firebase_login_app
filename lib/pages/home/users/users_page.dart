import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/users/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Center(
        child: Consumer<UsersModel>(
          builder: (context, model, _) {
            return model.users == null
                ? const CircularProgressIndicator()
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: model.users!.size,
                    itemBuilder: (context, index) {
                      final doc = model.users!.docs[index];

                      return UserTile(userDoc: doc);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                  );
          },
        ),
      ),
    );
  }
}
