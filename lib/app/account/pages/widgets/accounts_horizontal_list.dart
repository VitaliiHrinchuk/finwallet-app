import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_list_action.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_card.dart';

class AccountsHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      // return Container(
      //   height: 300,
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Expanded(child: AccountCard()),
      //           Expanded(child: AccountCard()),
      //         ],
      //       )
      //     ],
      //   ),
      // );
      List<AccountEntity> items = [];
      // List<int> items = [1,2,3,4,5,6,7];
      if (state is AccountFetched) {
        items = [...state.accounts];
      }

      return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 2 / 5.5,
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: items.map((e) => AccountCard()).toList()
      );

    });
  }
}
