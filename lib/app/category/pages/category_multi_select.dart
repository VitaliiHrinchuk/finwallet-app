import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/pages/widgets/category_icon.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/pages/list_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryMultiSelect extends StatefulWidget {
  List<CategoryEntity>? initialValue;

  CategoryMultiSelect({ this.initialValue });

  @override
  State<CategoryMultiSelect> createState() => _CategoryMultiSelectState();
}

class _CategoryMultiSelectState extends State<CategoryMultiSelect> {

  List<CategoryEntity> selected = [];

  @override
  void initState() {
    if (widget.initialValue != null) {
      selected = [...widget.initialValue!];
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListCubit, CategoryListState>(
      builder: (context, state) {
        return ListSearchPage<CategoryEntity>(
            title: 'Select Categories',
            entities: state.entities,
            selectable: true,
            onSubmit: () => Navigator.pop(context, this.selected),
            filterPredicate: (CategoryEntity element, String query) {
              return element.name.toLowerCase().contains(query);
            },
            itemBuilder: (CategoryEntity entity) {
              bool selected = this.selected.any((element) => element.id == entity.id);
              return ListTile(
                leading: CategoryIcon(slug: entity.slug),
                title: Text(entity.name),
                trailing: selected ? Icon(
                    Icons.check_circle,
                    color: PRIMARY_COLOR
                ) : null,
                onTap: () {
                  selectItem(entity);
                },
              );
            }
        );
      },
    );
  }

  void selectItem(CategoryEntity tag) {

    if (selected.any((element) => element.id == tag.id)) {
      selected.removeWhere((element) => element.id == tag.id);
    } else {
      selected.add(tag);
    }

    setState(() {
      selected = [...selected];
    });
  }
}
