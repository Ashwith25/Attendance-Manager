// ignore_for_file: file_names
import 'package:attendance_manager/Screens/student_list.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/models/attendance_model.dart';
import 'package:attendance_manager/models/class_model.dart';
import 'package:attendance_manager/services/attendance_service.dart';
import 'package:attendance_manager/services/class_service.dart';
import 'package:attendance_manager/services/toast_service.dart';
import 'package:attendance_manager/widgets/attendance.dart';
import 'package:attendance_manager/widgets/chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import 'markAttendance.dart';

class EachClass extends StatefulWidget {
  final String classId;
  final String teacherId;
  final String className;
  const EachClass(
      {Key? key,
      required this.classId,
      required this.teacherId,
      required this.className})
      : super(key: key);

  @override
  _EachClassState createState() => _EachClassState();
}

class _EachClassState extends State<EachClass> {
  List<Students> students = [];
  List<AttendanceModel> attendance = [];

  bool loading = true;
  List allStudents = [];

  late ClassModel classModel;

  getStudents() async {
    var data = await ClassService().getStudents();
    setState(() {
      allStudents = data;
      allStudents.removeWhere((element) => element["userType"] != "student");
    });
  }

  removeStudent(String studentId) async {
    var data = classModel;
    data.students!
        .removeWhere((element) => element.student![0].id == studentId);
    await ClassService().addStudent(data, widget.classId);
    setState(() {
      getClassDetails();
    });
  }

  getClassDetails() async {
    var data = await ClassService().getEachClassDetails(widget.classId);
    if (data.isNotEmpty) {
      setState(() {
        classModel = ClassModel.fromJson(data);
        students = data["students"]
            .map<Students>((json) => Students.fromJson(json))
            .toList();
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  getAttendance() async {
    var data = await AttendanceService().getAttendance(widget.classId);
    if (data.isNotEmpty) {
      setState(() {
        attendance = data
            .map<AttendanceModel>((json) => AttendanceModel.fromJson(json))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStudents();
    getAttendance();
    getClassDetails();
  }

  SwipeActionController? controller = SwipeActionController();

  MaterialBanner materialBanner(BuildContext context, int i, String studentId) {
    return MaterialBanner(
        content: const Text("Do you want to remove this student?"),
        actions: [
          TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                _flag = false;
                students.removeAt(i);
                removeStudent(studentId);
                ToastService.showToast("Student deleted", context);
                setState(() {});
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Theme.of(context).errorColor),
              )),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                _flag = false;
                controller!.closeAllOpenCell();
                setState(() {});
              },
              child: const Text("No")),
        ]);
  }

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _flag = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const Scaffold(
              // appBar: A,
              backgroundColor: Colors.blueGrey,
              body: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              appBar: AppBar(
                centerTitle: false,
                // leadingWidth: 0,
                elevation: 10,
                leading: AbsorbPointer(
                  absorbing: _flag,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                // leading: Container(
                //   width: 0,
                // ),
                actions: [
                  AbsorbPointer(
                    absorbing: _flag,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MarkAttendancePage(
                                        students: students,
                                        classId: widget.classId,
                                      )));
                          getAttendance();
                          getClassDetails();
                          setState(() {});
                        },
                      ),
                    ),
                  )
                ],
                title: Text(
                  'Class ${widget.className}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                foregroundColor: Theme.of(context).primaryColor,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await getClassDetails();
                  await getAttendance();
                  setState(() {});
                },
                child: AbsorbPointer(
                  absorbing: _flag,
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    centerTitle: false,
                                    // leadingWidth: 0,
                                    elevation: 10,
                                    leading: IconButton(
                                      color: Colors.white,
                                      icon: const Icon(
                                          Icons.arrow_back_ios_outlined),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .clearMaterialBanners();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    title: const Text(
                                      'Attendance',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  body: Container(
                                    height: size.height,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              "Attendance for class ${widget.className}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: goldenColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          for (int i = 0;
                                              i < attendance.length;
                                              i++)
                                            GestureDetector(
                                              onTap: () {
                                                List<Students> output = [];
                                                List presentIds = [];
                                                for (var student1
                                                    in attendance[i]
                                                        .studentPresent!) {
                                                  presentIds.add(
                                                      student1.student![0].id);
                                                }
                                                for (var student in students) {
                                                  if (!presentIds.contains(
                                                      student.student![0].id)) {
                                                    output.add(student);
                                                  }
                                                }
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return StudentPresentAbsent(
                                                    studentsPresent:
                                                        attendance[i]
                                                            .studentPresent!,
                                                    studentsAbsent:
                                                        output.toSet().toList(),
                                                  );
                                                }));
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: AttendanceCard(
                                                    totalAbsent:
                                                        students.length -
                                                            attendance[i]
                                                                .studentPresent!
                                                                .length,
                                                    totalPresent: attendance[i]
                                                        .studentPresent!
                                                        .length,
                                                    date: DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            attendance[i]
                                                                .publishedAt!)),
                                                  )),
                                            ),
                                          if (attendance.isEmpty)
                                            SizedBox(
                                              height: size.height * 0.8,
                                              child: Center(
                                                  child: Text(
                                                      'No attendance recorded',
                                                      style: TextStyle(
                                                        color: goldenColor,
                                                        fontSize: 15,
                                                      ))),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                            },
                            child: Neumorphic(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 10),
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(10)),
                                  depth: 3,
                                  intensity: 0.7,
                                  surfaceIntensity: 0.15,
                                  shadowDarkColor: Colors.black87,
                                  shadowDarkColorEmboss: Colors.black,
                                  shadowLightColor: Colors.grey[700],
                                  lightSource: LightSource.topLeft,
                                  color: Theme.of(context).primaryColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Text(
                                      "Attendance",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: goldenColor,
                                          ),
                                    ),
                                  ),
                                  // Expanded(child: SizedBox()),
                                  const SizedBox(width: 50),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: goldenColor,
                                  ),
                                  const SizedBox(height: 10),
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
                                  SizedBox(
                                      height: 250,
                                      width: MediaQuery.of(context).size.width,
                                      child: const AttendanceBarChart(
                                        value: [
                                          [0, "10"],
                                          [1, "20"],
                                          [2, "30"],
                                          [3, "40"],
                                          [4, "50"],
                                        ],
                                        interval: 25,
                                        maxValue: 100,
                                        data: [
                                          "Mon",
                                          "Tue",
                                          "Wed",
                                          "Thu",
                                          "Fri"
                                        ],
                                        expandValue: 1,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        .clearMaterialBanners();
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
                          const SizedBox(
                            height: 10,
                          ),
                          for (int i = 0; i < students.length; i++)
                            Container(
                              // color: Colors.white,
                              margin: const EdgeInsets.only(top: 10),
                              child: SwipeActionCell(
                                isDraggable: true,
                                backgroundColor: Colors.transparent,
                                controller: controller,
                                index: i,
                                key: ValueKey(students[i]),
                                normalAnimationDuration: 500,
                                deleteAnimationDuration: 500,
                                performsFirstActionWithFullSwipe: false,
                                leadingActions: [
                                  SwipeAction(
                                      // backgroundRadius: 12.0,
                                      widthSpace: 300,
                                      title: "delete",
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white),
                                      // nestedAction: SwipeNestedAction(title: "confirm"),
                                      onTap: (handler) async {
                                        _flag = true;
                                        // print("handler is ${handler}");
                                        // await handler(true);
                                        ScaffoldMessenger.of(context)
                                            .showMaterialBanner(materialBanner(
                                                context,
                                                i,
                                                students[i].student![0].id!));

                                        setState(() {});
                                      }),

                                  // SwipeAction(title: "action2", color: Colors.grey, onTap: (handler) {}),
                                ],
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                // top: 10,
                                                right: 5),
                                            width: 5,
                                            height: 75,
                                            // color: Theme.of(context).accentColor,
                                            // color: const Color(0xFFF5C35A),
                                            color: goldenColor,
                                          ),
                                          Container(
                                            // margin: const EdgeInsets.only(top: 10),
                                            height: 75,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            // width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    stops: const [
                                                  0.3,
                                                  1
                                                ],
                                                    colors: [
                                                  Colors.black38,
                                                  // Color.fromRGBO(0, 0, 0, 0.0)
                                                  Theme.of(context).primaryColor
                                                  // Colors.white
                                                ])),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    students[i]
                                                        .student![0]
                                                        .username
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: goldenColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    students[i]
                                                        .student![0]
                                                        .email!,
                                                    // style:
                                                    style: const TextStyle(
                                                      letterSpacing: 1,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontWeight: FontWeight.,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // NameCard(
                                      //   title: list[i]["name"],
                                      //   subtitle: list[i]["email"],
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          // ScaffoldMessenger.of(context)
                                          //     .showMaterialBanner(
                                          //         materialBanner(context, i));
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: Icon(
                                              Icons.double_arrow_sharp,
                                              color: goldenColor,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (students.isEmpty)
                            SizedBox(
                                height: 200,
                                child: Center(
                                    child: Text(
                                  "No students yet",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: goldenColor,
                                  ),
                                ))),

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
              ),
            ),
    );
  }

  // List emails = [
  //   "poojaryashan18it@student.mes.ac.in",
  //   "variarmanra18it@student.mes.ac.in",
  //   "ritikarad18it@student.mes.ac.in",
  //   "mhatrechisa18it@student.mes.ac.in",
  // ];

  // Map name = {
  //   "ashwith": "poojaryashan18it@student.mes.ac.in",
  //   "manasi": "variarmanra18it@student.mes.ac.in",
  //   "ritika": "ritikarad18it@student.mes.ac.in",
  //   "chinmay": "mhatrechisa18it@student.mes.ac.in",
  // };

  searchEmail() {
    if (_emailController.text.isEmpty) {
      return [];
    }
    // print('My med list: ${searchApi.medList}');

    return allStudents.where(
      (student) => student["email"]
          .toString()
          .toLowerCase()
          .contains(_emailController.text.toLowerCase()),
    );
  }

  addStudent(String studentId) async {
    var data = classModel.toJson();
    // data.students!.add(Students(student: [Student(id: studentId)]));
    var studentData = {
      "student": [
        {"_id": studentid, "id": studentid}
      ]
    };
    data["students"].add(studentData);
    await ClassService().addStudent(data, widget.classId);
    ToastService.showToast("Student added", context);
    setState(() {
      getClassDetails();
    });
  }

  late String studentid;

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
                            SizedBox(
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
                                Icons.cancel,
                                size: 30,
                                color: goldenColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
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
                              style: const TextStyle(color: Colors.white),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
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
                          noItemsFoundBuilder: (ctx) => const SizedBox(
                            height: 75,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
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
                                _nameController.text =
                                    (suggestion as Map)["username"] as String;
                                _emailController.text =
                                    (suggestion as Map)["email"];
                                studentid = (suggestion as Map)["id"];
                                // name.forEach((key, value) {
                                //   if (value.toString().toLowerCase() ==
                                //       suggestion.toString().toLowerCase()) {
                                //     _nameController.text =
                                //         key.toString().toUpperCase();
                                //   }
                                // });
                                FocusScope.of(context).unfocus();
                              },
                              child: SizedBox(
                                height: 75,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        (suggestion as Map)["email"] as String,
                                        style: const TextStyle(
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
                          onSuggestionSelected: (suggestion) {
                            // print("suggestion is $suggestion");
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _nameController,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name cannot be empty";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            // enableInteractiveSelection: true,
                            decoration: const InputDecoration(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            color: goldenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "Add student",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _emailController.clear();
                                _nameController.clear();
                                Navigator.of(context).pop();
                                addStudent(studentid);
                              }
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
