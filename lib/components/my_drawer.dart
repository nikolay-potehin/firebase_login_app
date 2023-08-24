import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index].title),
            leading: Icon(items[index].iconData),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class TileData {
  final String title;
  final IconData iconData;

  const TileData({
    required this.title,
    required this.iconData,
  });
}

final items = [
  const TileData(title: 'Profile', iconData: Icons.person),
  const TileData(title: 'Settings', iconData: Icons.settings),
  const TileData(title: 'Sign out', iconData: Icons.logout),
];
