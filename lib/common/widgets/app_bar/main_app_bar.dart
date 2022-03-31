import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;
  final List<Widget>? actions;

  MainAppBar({required this.title, this.canGoBack = false, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      centerTitle: true,
      actions: actions,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(this.title),
      bottom: PreferredSize(
          child: Container(
            color: Color(0xFFF2F2F2),
            height: 2,
          ),
          preferredSize: Size.fromHeight(kToolbarHeight)),
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
