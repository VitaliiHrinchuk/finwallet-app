import 'package:finwallet_app/common/constants/colors.dart';
import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {

  final Function(String value) onButtonTap;

  NumPad({
    required this.onButtonTap
  });

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
                NumButton('1', onTap: () => this.onButtonTap('1')),
                NumButton('2', onTap: () => this.onButtonTap('2')),
                NumButton('3', onTap: () => this.onButtonTap('3')),
                NumButton('*', secondary: true, onTap: () => this.onButtonTap('*')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('4', onTap: () =>this.onButtonTap('4')),
                NumButton('5', onTap: () =>this.onButtonTap('5')),
                NumButton('6', onTap: () =>this.onButtonTap('6')),
                NumButton('-', secondary: true, onTap: () => this.onButtonTap('-')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('7', onTap: () =>this.onButtonTap('7')),
                NumButton('8', onTap: () =>this.onButtonTap('8')),
                NumButton('9', onTap: () =>this.onButtonTap('9')),
                NumButton('+', secondary: true, onTap: () =>this.onButtonTap('+')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('.', onTap: () =>this.onButtonTap('.')),
                NumButton('0', onTap: () =>this.onButtonTap('0')),
                NumButton('<', onTap: () =>this.onButtonTap('<')),
                NumButton('=', secondary: true, onTap: () =>this.onButtonTap('=')),
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
  final Function onTap;

  NumButton(this.title, {this.secondary = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: SizedBox.expand(
          child: TextButton(
            onPressed: () => this.onTap(),
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: this.secondary ? PRIMARY_COLOR : null,
                    borderRadius: this.secondary ? BorderRadius.circular(50) : null
                ),
                child: Center(
                  child: Text(
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
            ),
                )),
          ),
        ),
      ),
    );
  }
}
