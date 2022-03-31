import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/pages/account_select.dart';
import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/setting_section.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/utils/hex_to_color_widget.dart';
import 'package:finwallet_app/common/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      // decoration: BoxDecoration(
      //     border:
      //         Border(top: BorderSide(width: 1, color: Colors.grey.shade200))),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<TransactionFormCubit, TransactionFormState>(
              builder: (context, state) {

                if (state.account != null) {
                  return SettingSection(
                    iconWidget: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColorWidget(state.account!.hexColor),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    title: state.account!.name,
                    onTap: () => _navigateAndSelectAccount(context),
                  );
                } else {
                  return LoadingSpinner();
                }


              },
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
          // TextButton(
          //   onPressed: () {},
          //   child: Icon(
          //     Icons.more_horiz_rounded,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }

  void _navigateAndSelectAccount(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (childContext) {
        return BlocProvider.value(
            value: BlocProvider.of<AccountsListCubit>(context),
            child: AccountSelect()
        );
      }),
    );

    print(result);
  }
}
