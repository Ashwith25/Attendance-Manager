import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/widgets/chart.dart';
import 'package:attendance_manager/widgets/homeScreenCard.dart';
import 'package:attendance_manager/widgets/nameCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EachClass extends StatefulWidget {
  const EachClass({Key? key}) : super(key: key);

  @override
  _EachClassState createState() => _EachClassState();
}

class _EachClassState extends State<EachClass> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // leadingWidth: 0,
          elevation: 10,
          // leading: Container(
          //   width: 0,
          // ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
          title: Text(
            'Class X',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            // color: Colors.grey,
            // color: Colors.red
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2.5,
                      lightSource: LightSource.topLeft,
                      color: Theme.of(context).primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          "Attendance",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: goldenColor,
                                  ),
                        ),
                      ),
                      // Expanded(child: SizedBox()),
                      SizedBox(width: 50),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: goldenColor,
                      ),
                      SizedBox(height: 10),
                      // isLoading
                      //     ? Container(
                      //         height: 250,
                      //         child: Center(
                      //           child: AnimatedBuilder(
                      //             animation: animationController,
                      //             child: new Container(
                      //               height: 50.0,
                      //               width: 50.0,
                      //               child: new Image.asset(
                      //                   ConstanceData.loader),
                      //             ),
                      //             builder: (BuildContext context,
                      //                 Widget _widget) {
                      //               return new Transform.rotate(
                      //                 angle: animationController.value * 10,
                      //                 child: _widget,
                      //               );
                      //             },
                      //           ),
                      //         ))
                      // :
                      // maxValue == 0
                      //     ? Container(
                      //         height: 250,
                      //         child: Center(
                      //           child: Text("No orders found"),
                      //         ),
                      //       )
                      // :
                      Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: AttendanceBarChart(
                            value: [
                              [0, "10"],
                              [1, "20"],
                              [2, "30"],
                              [3, "40"],
                              [4, "50"],
                            ],
                            interval: 25,
                            maxValue: 100,
                            data: ["Mon", "Tue", "Wed", "Thu", "Fri"],
                            expandValue: 1,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Students",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: goldenColor,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        size: 25,
                        color: goldenColor,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < 10; i++)
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        NameCard(
                          title: "Student ${i + 1}",
                          subtitle: "student${i + 1}@student.mes.ac.in",
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20, top: 10),
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Theme.of(context).errorColor,
                            ))
                      ],
                    ),
                  )
                // Container(
                //     height: size.height * .7,
                //     width: size.width,
                //     child: ListView.builder(
                //         padding:
                //             EdgeInsets.only(left: 10, right: 10, bottom: 10),
                //         itemCount: 10,
                //         itemBuilder: (context, index) => TeacherNameCard(
                //               className: "Class ${index + 1}",
                //               studentCount: index + 10,
                //             )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
