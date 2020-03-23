import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiver/iterables.dart';
import 'package:sampleapp/date.dart';

class WeeklyCalendar extends StatelessWidget {
  final OverlayState overlayState;
  final OverlayEntry overlayEntry;

  WeeklyCalendar({
    @required this.overlayState,
    @required this.overlayEntry,
  });

  @override
  Widget build(BuildContext context) {
    final double margin = 8.0;
    final double rightMargin = margin * 2;
    final double leftMargin = margin * 2;
    final cellWidth =
        (MediaQuery.of(context).size.width - (rightMargin + leftMargin)) *
            (1 / 7);
    final cellHeight = (MediaQuery.of(context).size.height - 32.0) * (1 / 8);

    final _weekName = ['日', '月', '火', '水', '木', '金', '土'];
    final currentMonth = DateTime.now().month;
    final _year = DateTime.now().year;
    final previousMonth = currentMonth - 1;
    final nextMonth = currentMonth + 1;

    final lastDateOfPreviousMonth = new DateTime(_year, currentMonth, 0);
    final lastDateOfCurrentMonth = new DateTime(_year, currentMonth + 1, 0);
    final lastDateOfNextMonth = new DateTime(_year, currentMonth + 2, 0);

    List<Date> daysLastMonth = List();
    List<Date> daysCurrentMonth = List();
    List<Date> daysNextMonth = List();

    final lastDayOfPreviousMonth =
        new DateTime(_year, previousMonth, lastDateOfPreviousMonth.day);

    for (final i in range(1, lastDayOfPreviousMonth.day + 1)) {
      var dateTime = new DateTime(_year, previousMonth, i);
      Date date = Date(
        month: dateTime.month,
        day: dateTime.day,
        weekday: dateTime.weekday,
        weekName: _weekName[7 - dateTime.weekday],
        isInCurrentMonth: dateTime.month == currentMonth,
      );
      daysLastMonth.add(date);
    }

    final lastDayOfCurrentMonth =
        new DateTime(_year, currentMonth, lastDateOfCurrentMonth.day);
    for (final i in range(1, lastDayOfCurrentMonth.day + 1)) {
      var dateTime = new DateTime(_year, currentMonth, i);
      Date date = Date(
        month: dateTime.month,
        day: dateTime.day,
        weekday: dateTime.weekday,
        weekName: _weekName[7 - dateTime.weekday],
        isInCurrentMonth: dateTime.month == currentMonth,
      );
      daysCurrentMonth.add(date);
    }

    final lastDayOfNextMonth =
        new DateTime(_year, nextMonth, lastDateOfNextMonth.day);
    for (final i in range(1, lastDayOfNextMonth.day + 1)) {
      var dateTime = new DateTime(_year, nextMonth, i);
      Date date = Date(
        month: dateTime.month,
        day: dateTime.day,
        weekday: dateTime.weekday,
        weekName: _weekName[7 - dateTime.weekday],
        isInCurrentMonth: dateTime.month == currentMonth,
      );
      daysNextMonth.add(date);
    }

    int currentDaysCount = 0;
    daysCurrentMonth.forEach((ele) {
      currentDaysCount += 1;
    });

    if (daysCurrentMonth.first.weekday != 7) {
      List reversed = daysLastMonth.reversed.toList();
      for (final i in range(0, daysCurrentMonth.first.weekday)) {
        daysCurrentMonth.insert(0, reversed[i]);
      }
    }

    if ((daysCurrentMonth.last.weekday != 7)) {
      for (final i in range(0, 7 - (daysCurrentMonth.last.weekday + 1))) {
        int index = currentDaysCount + i;
        daysCurrentMonth.insert(index, daysNextMonth[i]);
      }
    }

    int i = 0;
    return Wrap(
      children: daysCurrentMonth.map(
        (Date date) {
          Container container;
          i += 1;
          if ((i - 1) % 7 == 0) {
            Color textColor = date.isInCurrentMonth ? Colors.red : Colors.grey;
            container = Container(
              width: cellWidth,
              height: cellHeight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: textColor),
                ),
              ),
            );
          } else if (i % 7 == 0) {
            Color textColor = date.isInCurrentMonth ? Colors.blue : Colors.grey;
            container = Container(
              width: cellWidth,
              height: cellHeight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: textColor),
                ),
              ),
            );
          } else {
            Color textColor =
                date.isInCurrentMonth ? Colors.black : Colors.grey;
            container = Container(
              width: cellWidth,
              height: cellHeight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: textColor),
                ),
              ),
            );
          }
          return InkWell(
            child: container,
            onTap: () {
              showOverlay(context, this.overlayState, this.overlayEntry);
            },
          );
        },
      ).toList(),
    );
  }

  showOverlay(
    BuildContext context,
    OverlayState overlayState,
    OverlayEntry overlayEntry,
  ) async {
    double cardHeight =
        MediaQuery.of(context).size.height * (3/4);
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0.2),
          body: Center(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: PageController(viewportFraction: 0.9),
              children: <Widget>[
                Center(
                  child: Container(
                    height: cardHeight,
                    margin: EdgeInsets.only(left: 4.0, right: 4.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              overlayEntry.remove();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.amber,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: cardHeight,
                    margin: EdgeInsets.only(left: 4.0, right: 4.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              overlayEntry.remove();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.amber,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: cardHeight,
                    margin: EdgeInsets.only(left: 4.0, right: 4.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              overlayEntry.remove();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.blue,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                                Container(
                                  color: Colors.amber,
                                  height: 48.0,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    overlayState.insert(overlayEntry);
  }
}
