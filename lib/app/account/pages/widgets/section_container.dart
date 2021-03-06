import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {

  final Widget child;
  final String title;
  final Widget? leading;

  SectionContainer({
    required this.child,
    required this.title,
    this.leading
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 15, right: 15, top: this.leading == null ? 20 : 0 ),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10),
      //   // border: Border.all(color: Colors.grey.shade200)
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              this.leading == null ? Container() : this.leading!
            ],
          ),
          SizedBox(height: 5,),
          this.child
        ],
      ),
    );
  }
}
