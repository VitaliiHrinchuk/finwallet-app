import 'package:finwallet_app/common/widgets/app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class TransactionsListAppBar extends StatelessWidget implements PreferredSizeWidget  {
  @override
  Widget build(BuildContext context) {
    return GradientAppBar(
        child: Container(),
        firstColor: Color(0xFFFEC163),
        secondColor: Color(0xFFDE4313)
    );;
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
