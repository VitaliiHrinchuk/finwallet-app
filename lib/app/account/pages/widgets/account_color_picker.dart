import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AccountColorPicker extends StatelessWidget {

  Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      // margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,

      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(15),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: 30,
              color:  Colors.white ,
            ),
          ),
        ),
      ),
    );
  }

  Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Expanded(
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 5 : 10,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          shrinkWrap: true,
          children: [
            for (Color color in colors) Container(width:40, height: 40,child: child(color))
          ],
    ));
    // return Wrap(
    //   direction: Axis.horizontal,
    //   alignment: WrapAlignment.center,
    //   spacing: 10,
    //   children: [
    //     for (Color color in colors) Container(width:50, height: 50,child: child(color))
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlockPicker(
        pickerColor: Colors.white,
        onColorChanged: (Color color) {
          // Navigator.pop(context);
        },
        availableColors: ACCOUNTS_COLORS,
        layoutBuilder: pickerLayoutBuilder,
        itemBuilder: pickerItemBuilder,
      )
    );
  }
}
