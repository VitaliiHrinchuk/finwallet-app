import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/accounts_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/account_card.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/widgets/app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountAppBap extends StatefulWidget {
  final Function(AccountEntity? account) onAccountSelect;

  AccountAppBap({
    required this.onAccountSelect
  });

  @override
  State<AccountAppBap> createState() => _AccountAppBapState();
}

class _AccountAppBapState extends State<AccountAppBap> {
  final double appBarHeight = 40.0;
  final Color textColor = Colors.black;
  AccountEntity? selectedAccount;

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return GradientAppBar(
      firstColor: Color(0xFF97ABFF),
      secondColor: Color(0xFF123597),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Your Accounts",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
          // AccountsHorizontalList(),
          Container(
            height: 130,
            width: double.infinity,
            // margin: EdgeInsets.only(left: 10),
            child: AccountsHorizontalList(
              onAccountSelect: (AccountEntity? entity) {
                setState(() {
                  selectedAccount = entity;
                });
                widget.onAccountSelect(entity);
              },
              selectedAccount: selectedAccount,
            ),
          ),

        ],
      ),
    );
  }
}
