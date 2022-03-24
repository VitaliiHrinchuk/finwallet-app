import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/drawer_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        // bottom: PreferredSize(
        //     child: Container(
        //       color: Theme.of(context).colorScheme.secondary,
        //       height: 1,
        //     ),
        //     preferredSize: Size.fromHeight(4.0)),
        title: Text("Home"),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => di<AccountBloc>()..add(AccountFetch()),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Accounts",
                        style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                            Icons.settings,

                        )
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                    height: 140,
                    child: AccountsHorizontalList()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
