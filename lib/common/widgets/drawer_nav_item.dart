import 'package:flutter/material.dart';

class DrawerNavItem extends StatelessWidget {

  final Function() onTap;
  final String title;
  final bool selected;
  final IconData icon;

  DrawerNavItem({
    required this.onTap,
    required this.title,
    required this.icon,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {

    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Colors.white;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(6),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            color: !selected ? secondary : primary,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Icon(
            this.icon,
            color: selected ? secondary : primary,
            size: 20,
        ),
      ),
      dense:true,
      selected: selected,
      // shape:  RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      selectedColor: secondary,
      // selectedTileColor: Colors.grey.shade300,
      title: Text(
          this.title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primary
        ),
      ),
      onTap: this.onTap,
    );
  }
}
