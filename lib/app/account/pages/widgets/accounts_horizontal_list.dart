import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_list_action.dart';
import 'package:finwallet_app/common/widgets/loading_spinner.dart';
import 'package:finwallet_app/main/loading.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_card.dart';

class AccountsHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsListCubit, AccountsListState>(builder: (context, state) {
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

      if (state.loading) {
        return LoadingSpinner();
      }

      return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 2 / 5,
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: state.entities.map((e) => AccountCard(
            name: e.name,
            value: e.amount.toStringAsFixed(2) + " " + e.currency.code,
            color: e.hexColor
          )).toList()
      );

    });
  }
}
