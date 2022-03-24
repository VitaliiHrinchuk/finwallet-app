import 'package:finwallet_app/app/account/pages/widgets/account_card_container.dart';
import 'package:flutter/widgets.dart';

class AccountsListAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: AccountCardContainer(
        child: Column(
          children: [
            Text("Add Account")
          ],
        ),
      ),
    );
  }
}
