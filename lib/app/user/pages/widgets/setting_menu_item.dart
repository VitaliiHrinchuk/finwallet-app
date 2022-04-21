import 'package:flutter/material.dart';

class SettingMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  SettingMenuItem(this.title, { required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Icon(
          this.icon,
          size: 20,
          color: Colors.white,
        ),
      ),
      title: Text(
        this.title,
        style: TextStyle(
          fontSize: 18
        ),
      ),
      onTap: this.onTap,
    );
  }
}
