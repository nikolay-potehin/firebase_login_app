import 'package:firebase_login_app/components/my_error_widget.dart';
import 'package:firebase_login_app/models/app_data.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Center(
          child: FutureBuilder(
            future: AppData.users,
            initialData: const <UserData>[],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      snapshot.data![index].asWidget(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                );
              }

              if (snapshot.hasError) {
                return MyErrorWidget(message: snapshot.error.toString());
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    AppData.reloadUsers();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() {});
  }
}
