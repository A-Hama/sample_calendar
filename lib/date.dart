import 'package:flutter/cupertino.dart';

class Date {
  final int month;
  final int day;
  final int weekday;
  final String weekName;
  final bool isInCurrentMonth;

  Date({
    @required this.month,
    @required this.day,
    @required this.weekday,
    @required this.weekName,
    @required this.isInCurrentMonth,
  });
}
