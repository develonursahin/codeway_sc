import 'package:flutter/material.dart';

extension SizeBoxExtension on num {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
  Widget get heightWidth => SizedBox(height: toDouble(), width: toDouble());
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());
}
