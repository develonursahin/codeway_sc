import 'package:flutter/material.dart';
import 'package:plantist/core/widgets/progressIndicator/custom_circular_progress_indicator_widget.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const CustomCircularProgressIndicator();
    },
  );
}
