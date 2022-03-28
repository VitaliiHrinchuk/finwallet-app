import 'package:finwallet_app/app/transaction/pages/widgets/setting_section.dart';
import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade200))),
      child: Row(
        children: [
          Expanded(
            child: SettingSection(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
              ),
              title: 'Test',
              onTap: () {},
            ),
          ),
          // Icon(
          //   Icons.arrow_forward_rounded,
          //   color: Colors.grey,
          // ),
          Expanded(
            child: SettingSection(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
              ),
              title: 'Home & Appliance',
              onTap: () {},
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.more_horiz_rounded,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
