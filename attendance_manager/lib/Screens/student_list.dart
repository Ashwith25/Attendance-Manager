import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/class_model.dart';
import '../widgets/nameCard.dart';

class StudentPresentAbsent extends StatefulWidget {
  final List<Students> studentsPresent;
  final List<Students> studentsAbsent;
  const StudentPresentAbsent({
    Key? key,
    required this.studentsPresent,
    required this.studentsAbsent,
  }) : super(key: key);

  @override
  _StudentPresentAbsentState createState() => _StudentPresentAbsentState();
}

class _StudentPresentAbsentState extends State<StudentPresentAbsent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // leadingWidth: 0,
          elevation: 10,
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Students list',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Column(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.greenAccent,
                    ),
                    Text(
                      "Present",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Tab(
                icon: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).errorColor,
                    ),
                    const Text(
                      "Absent",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < widget.studentsPresent.length; i++)
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: NameCard(
                            height: 75,
                            title: widget
                                .studentsPresent[i].student![0].username
                                .toString()
                                .toUpperCase(),
                            subtitle: widget
                                .studentsPresent[i].student![0].email
                                .toString()
                                .toUpperCase(),
                          ))
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < widget.studentsAbsent.length; i++)
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: NameCard(
                            height: 75,
                            title: widget.studentsAbsent[i].student![0].username
                                .toString()
                                .toUpperCase(),
                            subtitle: widget.studentsAbsent[i].student![0].email
                                .toString()
                                .toUpperCase(),
                          ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
