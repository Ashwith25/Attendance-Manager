// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:attendance_manager/Flutter-Neumorphic-master/Flutter-Neumorphic-master/lib/flutter_neumorphic.dart';

class HomeScreenCard extends StatelessWidget {
  final title;
  final icon;
  const HomeScreenCard({Key? key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          depth: 2.5,
          lightSource: LightSource.topLeft,
          color: Theme.of(context).primaryColor),
      child: Container(
        height: 75,
        // width: MediaQuery.of(context).size.width * 0.45,
        width: 150,
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.bold, color: goldenColor),
              ),
              // Image.asset(icon)
              Icon(
                icon,
                color: goldenColor,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
