import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                NumButton('1'),
                NumButton('2'),
                NumButton('3'),
                NumButton('*', secondary: true),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('4'),
                NumButton('5'),
                NumButton('6'),
                NumButton('-', secondary: true),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('7'),
                NumButton('8'),
                NumButton('9'),
                NumButton('+', secondary: true),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('.'),
                NumButton('0'),
                NumButton('<'),
                NumButton('=', secondary: true),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NumButton extends StatelessWidget {
  final String title;
  final bool secondary;

  NumButton(this.title, {this.secondary = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: this.secondary ? Colors.grey.shade100 : null ,
        // decoration: BoxDecoration(
        //   border: this.secondary ? Border(
        //     left: BorderSide(width: 1, color: Colors.grey),
        //   ) : null
        // ),
        child: SizedBox.expand(
          child: TextButton(
            onPressed: () {},
            child: Container(
                child: Text(
                  this.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
            )),
          ),
        ),
      ),
    );
  }
}
