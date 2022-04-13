import 'package:finwallet_app/app/account/pages/widgets/account_card_container.dart';
import 'package:finwallet_app/common/constants/colors.dart';
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
    Color color = this.color != null ? Color(int.parse('0xFF${this.color}')) : PRIMARY_COLOR;
    return GestureDetector(
      onTap: () => {},
      child: AccountCardContainer(
        color: color,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,

                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      value,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
