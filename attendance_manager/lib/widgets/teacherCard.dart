import 'package:flutter/material.dart';

class TeacherNameCard extends StatelessWidget {
  final className;
  final studentCount;
  const TeacherNameCard({Key? key, this.className, this.studentCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 75,
      // width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.centerLeft, stops: [
        0.3,
        1
      ], colors: [
        Theme.of(context).primaryColor,
        Color.fromRGBO(0, 0, 0, 0.0)
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
    );
  }
}
