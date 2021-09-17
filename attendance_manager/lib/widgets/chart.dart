import 'dart:async';
import 'package:attendance_manager/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AttendanceBarChart extends StatefulWidget {
  final data;
  final value;
  final interval;
  final maxValue;
  final expandValue;

  const AttendanceBarChart(
      {Key? key, this.data, this.value, this.interval, this.maxValue, this.expandValue})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => BarChartState();
}

class BarChartState extends State<AttendanceBarChart> {
  final Color barBackgroundColor = Colors.black38;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: BarChart(
                mainBarData(),
                swapAnimationDuration: animDuration,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    var value, {
    bool isTouched = false,
    Color barColor = Colors.blueGrey,
    double width = 25,
  }) {
    // print(value);
    return BarChartGroupData(
      x: value[0],
      barRods: [
        BarChartRodData(
          y: isTouched
              ? double.parse(value[1].toString()) + widget.expandValue
              : double.parse(value[1].toString()),
          colors: isTouched ? [goldenColor] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: double.parse(widget.maxValue.toString()),
            colors: [barBackgroundColor],
          ),
        ),
      ],
      //showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(widget.value[0], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(widget.value[1], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(widget.value[2], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(widget.value[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(widget.value[4], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(widget.value[5], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(widget.value[6], isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = widget.data[0];
                  break;
                case 1:
                  weekDay = widget.data[1];
                  break;
                case 2:
                  weekDay = widget.data[2];
                  break;
                case 3:
                  weekDay = widget.data[3];
                  break;
                case 4:
                  weekDay = widget.data[4];
                  break;
                case 5:
                  weekDay = widget.data[5];
                  break;
                // case 6:
                //   weekDay = 'July';
                //   break;
                default:
                  throw Error();
              }

              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - widget.expandValue).toString(),
                    style: TextStyle(
                      color: goldenColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          // reservedSize: 0,
          showTitles: true,
          getTextStyles: (value, _) => TextStyle(
              color: goldenColor, fontWeight: FontWeight.bold, fontSize: 13),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return widget.data[0];
              case 1:
                return widget.data[1];
              case 2:
                return widget.data[2];
              case 3:
                return widget.data[3];
              case 4:
                return widget.data[4];
              case 5:
                return widget.data[5];
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
            getTextStyles: (value, _) => TextStyle(
                color: goldenColor, fontWeight: FontWeight.w100, fontSize: 13),
            reservedSize: 30,
            margin: 20,
            showTitles: true,
            interval: double.parse(widget.interval.toString())),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
