import 'package:flutter/material.dart';

import '../../../../common/widgets/placeholder.dart';

class EmptyTransactionsListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContentPlaceholder(title: 'Looks like you don`t have any transaction with selected filters'),
    );
  }
}
