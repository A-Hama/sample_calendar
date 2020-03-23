import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekdayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double margin = 8.0;
    final double rightMargin = margin * 2;
    final double leftMargin = margin * 2;
    final cellWidth =
        (MediaQuery.of(context).size.width - (rightMargin + leftMargin)) *
            (1 / 7);
    final cellHeight = (MediaQuery.of(context).size.height - 32.0) * (1 / 8);
    final _weekNames = [
      {"day": "日", "color": Colors.red},
      {"day": "月", "color": Colors.black},
      {"day": "火", "color": Colors.black},
      {"day": "水", "color": Colors.black},
      {"day": "木", "color": Colors.black},
      {"day": "金", "color": Colors.black},
      {"day": "土", "color": Colors.blue},
    ];

    return Row(
      children: _weekNames.map(
        (_weekName) {
          return Container(
            width: cellWidth,
            height: cellHeight * (1 / 2),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                _weekName["day"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _weekName["color"]
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
