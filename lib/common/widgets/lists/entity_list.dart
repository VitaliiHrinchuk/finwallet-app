import 'package:flutter/material.dart';

class EntityList<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function() onScrollBottom;
  final void Function() onRefresh;

  const EntityList({
    Key? key,
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.itemBuilder,
    required this.onScrollBottom,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _EntityListState createState() => _EntityListState<T>(
      items: items
  );
}

class _EntityListState<T> extends State<EntityList> {

  final ScrollController _scrollController = ScrollController();
  final List<T> items;

  _EntityListState({
    required this.items
  });

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        separatorBuilder: (context, i) => Divider(color: Colors.grey),
        itemCount: (items.length + 1), // plus one item for indicator
        itemBuilder: (context, i) {
          if (i < items.length) {
            return widget.itemBuilder(context, items[i]);
          } else {
            return Container(
              margin: EdgeInsets.only(top: 18, bottom: 18),
              height: 36,
              width: 36,
              child: (widget.hasMore != true)
                  ? Center(child: CircularProgressIndicator())
                  : Center(child: Text('No more entries found')),
            );
          }
        }
    );
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) widget.onScrollBottom();
  }
}
