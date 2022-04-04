import 'package:finwallet_app/app/account/pages/widgets/account_card_container.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String value;
  final String? color;

  AccountCard({
    required this.name,
    required this.value,
    this.color
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => {},
      child: AccountCardContainer(
        color: this.color != null ? Color(int.parse('0xFF${color}')) : null ,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          )
      ),
    );
  }
}
