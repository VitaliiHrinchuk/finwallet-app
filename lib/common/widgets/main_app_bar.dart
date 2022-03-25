import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;

  MainAppBar({required this.title, this.canGoBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(this.title),
      leading: this.canGoBack
          ? IconButton(
              icon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
