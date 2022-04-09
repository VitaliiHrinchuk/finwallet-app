
import 'package:finwallet_app/app/tag/cubit/list/tag_list_cubit.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/pages/list_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagSelect extends StatefulWidget {

  List<TagEntity>? initialValue;

  TagSelect({ this.initialValue });

  @override
  State<TagSelect> createState() => _TagSelectState();
}

class _TagSelectState extends State<TagSelect> {

  List<TagEntity> selected = [];

  @override
  void initState() {
    if (widget.initialValue != null) {
      selected = [...widget.initialValue!];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagListCubit, TagListState>(
      builder: (context, state) {
        return ListSearchPage<TagEntity>(
            title: 'Select Tag',
            selectable: true,
            entities: state.entities,
            onSubmit: () => Navigator.pop(context, this.selected),
            filterPredicate: (TagEntity element, String query) {
              return element.name.toLowerCase().contains(query);
            },
            itemBuilder: (TagEntity entity) {
              bool selected = this.selected.any((element) => element.id == entity.id);
              return ListTile(
                title: Text(entity.name),
                dense: true,
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

  void selectItem(TagEntity tag) {

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
