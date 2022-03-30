import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {

  final String title;
  final Widget iconWidget;
  final Function() onTap;

  SettingSection({
    required this.title,
    required this.iconWidget,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(
        onPressed: this.onTap,
        child: Row(
          children: [
            this.iconWidget,
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
