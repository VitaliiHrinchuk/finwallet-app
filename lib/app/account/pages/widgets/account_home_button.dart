import 'package:flutter/material.dart';

class AccountHomeButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onTap;

  AccountHomeButton({
    required this.icon,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onTap(),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30)
              ),

              child: Icon(
                  this.icon,
                  size: 25,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 20),
            Text(
                this.title,
                style: TextStyle(
                  fontSize: 14
                ),
            )
          ],
        )
    );
  }
}
