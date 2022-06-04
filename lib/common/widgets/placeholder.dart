import 'package:flutter/material.dart';


class ContentPlaceholder extends StatelessWidget {
  final String title;

  ContentPlaceholder({
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 75, right: 75, top: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 100,
              image: AssetImage('assets/placeholder.png'),
            ),
            SizedBox(height: 10),
            Text(
                title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
        )
    );
  }
}
