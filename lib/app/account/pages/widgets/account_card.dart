import 'package:finwallet_app/app/account/pages/widgets/account_card_container.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: AccountCardContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$200",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          )
      ),
    );
  }
}
