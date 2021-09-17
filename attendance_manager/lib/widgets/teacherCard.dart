import 'package:flutter/material.dart';

class TeacherNameCard extends StatelessWidget {
  final className;
  final studentCount;
  const TeacherNameCard({Key? key, this.className, this.studentCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, right: 5),
          width: 5,
          height: 75,
          // color: Theme.of(context).accentColor,
          color: Color(0xFFF5C35A),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 75,
          width: MediaQuery.of(context).size.width * 0.85,
          // width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, stops: [
            0.2,
            0.5,
            0.7,
            1
          ], colors: [
            Colors.black38,
            Colors.black26,
            Colors.black12,
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
                Text(
                  className,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$studentCount students",
                  // style:
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    // fontWeight: FontWeight.,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
