import 'package:finwallet_app/common/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';

Dialog loadingDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    height: 200.0,
    width: 200.0,

    child: LoadingSpinner()
  ),
);

Future showLoadingDialog(context) {
  return showDialog(context: context, builder: (BuildContext context) => loadingDialog);
}