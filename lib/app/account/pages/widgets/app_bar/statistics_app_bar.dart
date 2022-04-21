import 'package:finwallet_app/common/widgets/app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class StatisticsAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {

    return GradientAppBar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Statistics",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
        firstColor: Color(0xFFEE9AE5),
        secondColor: Color(0xFF5961F9)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
