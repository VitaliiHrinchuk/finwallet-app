import 'package:flutter/material.dart';

class FiltersSection extends StatelessWidget {
  final Widget child;
  final String title;

  FiltersSection({
    required this.child,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          this.child
        ],
      ),
    );
  }
}
