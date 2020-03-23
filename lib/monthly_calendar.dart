import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleapp/weekday_header.dart';
import 'package:sampleapp/weekly_calendar.dart';

class MonthlyCalendar extends StatelessWidget {
  OverlayState overlayState;
  OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    final double margin = 8.0;
    final double topMargin = margin * 2;
    final double rightMargin = margin * 2;
    final double leftMargin = margin * 2;
    final double bottomMargin = margin * 8;
    final Widget _weekdayHeader = WeekdayHeader();
    final Widget _weeklyCalendar = WeeklyCalendar(
      overlayState: overlayState,
      overlayEntry: overlayEntry,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width - (rightMargin + leftMargin),
            margin: EdgeInsets.only(
              top: topMargin,
              right: rightMargin,
              left: leftMargin,
              bottom: bottomMargin,
            ),
            child: Column(
              children: <Widget>[_weekdayHeader, _weeklyCalendar],
            ),
          ),
        ),
      ),
    );
  }
}
