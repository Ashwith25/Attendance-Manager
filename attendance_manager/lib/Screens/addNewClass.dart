import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddNewClassPage extends StatefulWidget {
  AddNewClassPage({Key? key}) : super(key: key);

  @override
  _AddNewClassPageState createState() => _AddNewClassPageState();
}

class _AddNewClassPageState extends State<AddNewClassPage> {
  var _year = ["FE", "SE", "TE", "BE"];
  var _branch = ["COMPS", "IT", "EXTC", "ETRX", "AUTOMOBILE", "MECHANICAL"];
  var _subject = ["Artifical Intelligence", "Enterprise Network design", "CSL"];

  final _formKey = GlobalKey<FormBuilderState>();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Add new class',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'year',
                    decoration: InputDecoration(
                        // errorText: "Year is required",
                        helperStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Select Year",
                        labelStyle: TextStyle(color: Colors.white)),
                    // initialValue: 'Male',
                    dropdownColor: Theme.of(context).primaryColor,
                    allowClear: true,
                    clearIcon: Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _year
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text('$year', style: TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'branch',
                    decoration: InputDecoration(
                        // errorText: "Branch is required",
                        helperStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Select Branch",
                        labelStyle: TextStyle(color: Colors.white)),
                    // initialValue: 'Male',
                    dropdownColor: Theme.of(context).primaryColor,
                    allowClear: true,
                    clearIcon: Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _branch
                        .map((branch) => DropdownMenuItem(
                              value: branch,
                              child: Text('$branch', style: TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'subject',
                    decoration: InputDecoration(
                        // errorText: "Subject is required",
                        helperStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Select Subject",
                        labelStyle: TextStyle(color: Colors.white)),
                    // initialValue: 'Male',
                    allowClear: true,
                    dropdownColor: Theme.of(context).primaryColor,
                    clearIcon: Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _subject
                        .map((subject) => DropdownMenuItem(
                              value: subject,
                              child: Text('$subject', style: TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
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
                      "Add class",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState!.fields["subject"]!.value);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
