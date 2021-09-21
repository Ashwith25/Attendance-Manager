import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/widgets/chart.dart';
import 'package:attendance_manager/widgets/nameCard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:attendance_manager/Flutter-Neumorphic-master/Flutter-Neumorphic-master/lib/flutter_neumorphic.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'markAttendance.dart';

class EachClass extends StatefulWidget {
  const EachClass({Key? key}) : super(key: key);

  @override
  _EachClassState createState() => _EachClassState();
}

class _EachClassState extends State<EachClass> {
  MaterialBanner materialBanner(BuildContext context) {
    return MaterialBanner(
        content: const Text("Do you want to remove this student?"),
        actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Theme.of(context).errorColor),
              )),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text("No")),
        ]);
  }

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // leadingWidth: 0,
          elevation: 10,
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () { 
              ScaffoldMessenger.of(context).clearMaterialBanners();
              Navigator.of(context).pop();
            },
          ),
          // leading: Container(
          //   width: 0,
          // ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 0),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarkAttendancePage()));
                },
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
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                          popUp();
                        },
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: goldenColor,
                        ),
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
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .showMaterialBanner(materialBanner(context));
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 20, top: 10),
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Theme.of(context).errorColor,
                              )),
                        )
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

  List emails = [
    "poojaryashan18it@student.mes.ac.in",
    "variarmanra18it@student.mes.ac.in",
    "ritikarad18it@student.mes.ac.in",
    "mhatrechisa18it@student.mes.ac.in",
  ];

  searchEmail() {
    if (_emailController.text.isEmpty) {
      return [];
    }
    // print('My med list: ${searchApi.medList}');

    return emails.where(
      (email) => email
          .toString()
          .toLowerCase()
          .contains(_emailController.text.toLowerCase()),
    );
  }

  popUp() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              content: Container(
                height: 400,
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: FittedBox(
                                child: Text(
                                  "Add new student",
                                  style: TextStyle(
                                      color: goldenColor, fontSize: 25),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                size: 35,
                                color: goldenColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: _emailController,
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              // autofocus: true,
                              style: TextStyle(color: Colors.white),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Student email",
                                  labelStyle: TextStyle(color: Colors.white))),
                          suggestionsCallback: (pattern) async {
                            return searchEmail();
                          },
                          noItemsFoundBuilder: (ctx) => Container(
                            height: 75,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "No suggestions",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // validator: _validateStockName,
                          itemBuilder: (context, suggestion) {
                            return GestureDetector(
                              onTap: () {
                                print(suggestion);
                              },
                              child: Container(
                                height: 75,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        suggestion as String,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: TextFormField(
                              controller: _nameController,
                              readOnly: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              // enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  helperText: "This will autofill",
                                  helperStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Student name",
                                  labelStyle: TextStyle(color: Colors.white))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            color: goldenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Add student",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate())
                                Navigator.of(context).pop();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => TeacherHome()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
