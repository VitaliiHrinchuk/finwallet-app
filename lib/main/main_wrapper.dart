import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/pages/accounts_home.dart';
import 'package:finwallet_app/app/account/pages/accounts_list.dart';
import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/tag/cubit/list/tag_list_cubit.dart';
import 'package:finwallet_app/app/transaction/pages/add_transaction.dart';
import 'package:finwallet_app/app/transaction/pages/list_transactions.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    AccountsHome(),
    Text(
      'Statistics',
      style: optionStyle,
    ),
    // AddTransaction(),
    ListTransactions(),
    Text(
      'Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryListCubit>(context).load(null);
    BlocProvider.of<TagListCubit>(context).load();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_sharp),
            activeIcon: Icon(Icons.insert_chart_sharp),
            label: 'Statistics',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_circle_outline_rounded),
          //   label: 'New Record',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            activeIcon: Icon(Icons.list),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        // backgroundColor: Colors.black,
      ),
    );
  }
}
