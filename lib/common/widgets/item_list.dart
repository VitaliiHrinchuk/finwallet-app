import 'package:flutter/material.dart';

import 'list_loader.dart';

class ItemList<T> extends StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final ScrollController controller;
  final List<T> items;
  final void Function() onNextPage;
  final void Function() onRefreshPage;
  final Widget Function(BuildContext, T) itemBuilder;

  ItemList({
    Key? key,
    required this.isLoading,
    required this.hasMore,
    required this.controller,
    required this.items,
    required this.onRefreshPage,
    required this.onNextPage,
    required this.itemBuilder
  }): super(key: key);


  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async => onRefreshPage(),
      child: Builder(
        builder: (context) {
          if (isLoading != true)  {
            return ListView.separated(
                separatorBuilder: (context,index) => Divider(),
                physics: BouncingScrollPhysics(),
                controller: controller,
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    return itemBuilder(context, items[index]);
                  } else {
                    if (hasMore) {
                      return CircularProgressIndicator();
                    } else {
                      return Center(child: Text('No more items'));
                    }
                  }
                }
            );
          } else {
            return ListLoader();
          }
        },
      ),
    );
  }
}