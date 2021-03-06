// ignore_for_file: file_names

import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';

class AttendanceStatusCard extends StatelessWidget {
  final String date;
  final String status;
  const AttendanceStatusCard({
    Key? key,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, right: 5),
          width: 5,
          height: 75,
          // color: Theme.of(context).accentColor,
          // color: const Color(0xFFF5C35A),
          color: goldenColor,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 75,
          width: MediaQuery.of(context).size.width * 0.85,
          // width: double.infinity,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.centerLeft, stops: const [
            0.3,
            1
          ], colors: [
            Colors.black38,
            // Color.fromRGBO(0, 0, 0, 0.0)
            Theme.of(context).primaryColor
            // Colors.white
          ])),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      date.toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: goldenColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$status".toUpperCase(),
                      // style:
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        // fontWeight: FontWeight.,
                        color: status.toLowerCase() == "present"
                            ? Colors.greenAccent
                            : Theme.of(context).errorColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
