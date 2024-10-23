import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantist/core/constants/app_color.dart';

extension StringExtension on String {
  bool get isEmail => contains("@") && contains(".");
  bool get isNotShort => length >= 4;
}

extension SvgExtension on String {
  Widget get toSvg => SvgPicture.asset(this);
  Widget toColorSvg({Color? color}) => SvgPicture.asset(this, color: color);
}

extension ImagesExtension on String {
  Widget get toImage => Image.asset(
        this,
        fit: BoxFit.fill,
      );
  AssetImage get toImageProvider => AssetImage(this);
}

extension EmailValidateExtension on String {
  bool get emailValidate =>
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(this);
  bool isValidEmail() {
    // Simple regex for email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}

extension DateTimeExtensions on DateTime {
  String toFormattedString({bool? isHour = true}) {
    return isHour == true
        ? "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}"
        : "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString()}";
  }
}

extension StringHtmlExtension on String {
  String removeHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }
}

extension UrlExtension on String {
  String getFileTypeFromUrl() {
    var uri = Uri.parse(this);
    var segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      var lastSegment = segments.last.replaceAll(' ', '_');
      if (lastSegment.contains('.')) {
        return lastSegment.split('.').last;
      }
    }
    return 'pdf';
  }
}

extension TimeAgo on String {
  String toTimeAgo() {
    DateTime dateTime = DateTime.parse(this);
    Duration difference = DateTime.now().toUtc().difference(dateTime.toUtc());

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}d';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}sa';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}g';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}a';
    } else {
      return '${(difference.inDays / 365).floor()}y';
    }
  }
}

Color getPriorityColor(int priority) {
  switch (priority) {
    case 0:
      return AppColor.red;
    case 1:
      return AppColor.orange;
    case 2:
      return AppColor.green;
    case 3:
      return AppColor.blue;
    default:
      return AppColor.grey;
  }
}

extension DateTimeFormatting on DateTime {
  String dateRefactoring() {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return '$day ${months[month - 1]} $year';
  }

  String monthRefactoring() {
    String formattedDay = day.toString().padLeft(2, '0');
    String formattedMonth = month.toString().padLeft(2, '0');
    return '$formattedDay.$formattedMonth.$year';
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String toTimeOfDay() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

extension StringTimeExtension on String? {
  TimeOfDay? toTimeOfDay() {
    if (this == null || this!.isEmpty) return null;

    final parts = this!.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }
}
