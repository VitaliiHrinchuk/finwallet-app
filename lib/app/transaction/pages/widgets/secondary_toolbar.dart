import 'package:flutter/material.dart';

class SecondaryToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Today",
                style: TextStyle(
                    color: Colors.grey
                ),
              )
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.circle,
              size: 5,
              color: Colors.grey.shade300,
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Add Tags",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400
                ),
              )
          ),
        ],
      ),
    );
  }
}
