import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/pages/category_edit.dart';
import 'package:finwallet_app/app/tag/cubit/list/tag_list_cubit.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/pages/tag_edit.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TagList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Tags",
        canGoBack: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (childContext) {
                    return TagEdit();
                  }),
                );

                BlocProvider.of<TagListCubit>(context).load();
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<TagListCubit, TagListState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state.customTags.length,
                itemBuilder: (context, i) {
                  TagEntity entity = state.customTags[i];
                  return ListTile(
                    title: Text(entity.name),
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (childContext) {
                          return TagEdit(entity: entity);
                        }),
                      );

                      BlocProvider.of<TagListCubit>(context).load();
                    },
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
