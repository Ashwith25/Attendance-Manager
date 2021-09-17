import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
  final title;
  final subtitle;
  const NameCard({Key? key, this.title, this.subtitle})
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$subtitle",
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
