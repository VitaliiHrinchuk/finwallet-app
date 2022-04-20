import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/account_select.dart';
import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/pages/category_multi_select.dart';
import 'package:finwallet_app/app/category/pages/category_select.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/utils/hex_to_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFilter extends StatelessWidget {

  final Function(List<CategoryEntity> value) onChange;
  final List<CategoryEntity> values;

  CategoryFilter({
    required this.values,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...this.values.map((e) {
          return Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Chip(
                      backgroundColor: Colors.black,
                      deleteIconColor: Colors.white,
                      label: Text(e.name, style: TextStyle(color: Colors.white)),
                      onDeleted: () {
                        List<CategoryEntity> values = [...this.values];
                        values.removeWhere((element) => element.id == e.id);

                        this.onChange(values);
                      },
                      deleteIcon: Icon(Icons.clear),
                  ),
                );
        }).toList(),
        IconButton(
            onPressed: () async {
              List<CategoryEntity>? values = await _navigateAndSelectCategories(context);

              if(values != null) {
                this.onChange(values);
              }
            },
            icon: Icon(Icons.add)
        )
      ],
    );
  }

  Future<List<CategoryEntity>?> _navigateAndSelectCategories(BuildContext context) async {
    final List<CategoryEntity>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (childContext) {
        return BlocProvider.value(
            value: BlocProvider.of<CategoryListCubit>(context),
            child: CategoryMultiSelect(initialValue: this.values));
      }),
    );

    return result;
  }
}
