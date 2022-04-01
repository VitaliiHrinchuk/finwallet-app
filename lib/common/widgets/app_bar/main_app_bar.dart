import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;
  final List<Widget>? actions;
  final Function(String query)? onSearchChanged;
  final bool enableSearch;

  MainAppBar({
    required this.title,
    this.canGoBack = false,
    this.actions,
    this.onSearchChanged,
    this.enableSearch = false
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  TextEditingController _searchQueryController = TextEditingController();
  bool isSearch = false;

  bool get activeSearch  => widget.enableSearch && this.isSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      title: activeSearch ? this._buildSearchField() : Text(this.widget.title),
      bottom: PreferredSize(
          child: Container(
            color: Color(0xFFF2F2F2),
            height: 2,
          ),
          preferredSize: Size.fromHeight(kToolbarHeight)),
      leading: this.widget.canGoBack
          ? IconButton(
              icon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      backgroundColor: Colors.white,
      actions: _buildActions(),
    );
  }


  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      controller: _searchQueryController,
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,

      ),
      onChanged: (query) => this.widget.onSearchChanged != null ? this.widget.onSearchChanged!(query) : null,
    );
  }

  List<Widget> _buildActions() {
    if (widget.enableSearch) {

      if (this.isSearch) {
        return <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              this._searchQueryController.clear();
            },
          ),
        ];
      } else {

        return <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ];
      }
    } else {
      return widget.actions ?? [];
    }

  }

  void _startSearch() {
    // ModalRoute.of(context)
    //     .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      isSearch = true;
    });
  }
}
