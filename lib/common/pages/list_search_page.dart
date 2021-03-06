import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class ListSearchPage<T> extends StatefulWidget {

  final List<T> entities;
  final String title;
  // final Function(T entity)? onSelect;
  final bool Function(T entity, String query) filterPredicate;
  final Widget Function(T entity) itemBuilder;
  final bool selectable;
  final Function? onSubmit;

  ListSearchPage({
    required this.title,
    required this.entities,
    // required this.onSelect,
    required this.filterPredicate,
    required this.itemBuilder,
    this.selectable = false,
    this.onSubmit
  });

  @override
  State<ListSearchPage<T>> createState() => _ListSearchPageState<T>();
}

class _ListSearchPageState<T> extends State<ListSearchPage<T>> {

  String query = "";

  @override
  Widget build(BuildContext context) {

    List<T> filtered = [];

    if (this.query == '') {
      filtered = widget.entities;
    } else {
      filtered = widget.entities.where((T element) => widget.filterPredicate(element, query)).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: widget.title,
        canGoBack: true,
        enableSearch: true,
        actions: widget.selectable ? [
          IconButton(
            icon: Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
            onPressed: () => widget.onSubmit != null ? widget.onSubmit!() : null,
          )
        ] : null,
        onSearchChanged: (String value) {
          setState(() {
            query = value;
          });
        },
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            padding: EdgeInsets.zero,
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              T entity = filtered[i];

              return widget.itemBuilder(entity);
            },
          )
      ),
    );
  }
}


