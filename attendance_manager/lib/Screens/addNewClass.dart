// ignore_for_file: file_names

import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddNewClassPage extends StatefulWidget {
  const AddNewClassPage({Key? key}) : super(key: key);

  @override
  _AddNewClassPageState createState() => _AddNewClassPageState();
}

class _AddNewClassPageState extends State<AddNewClassPage> {
  final List<String> _year = ["FE", "SE", "TE", "BE"];
  final List<String> _branch = ["COMPS", "IT", "EXTC", "ETRX", "AUTOMOBILE", "MECHANICAL"];
  final List<String> _subject = ["Artifical Intelligence", "Enterprise Network design", "CSL"];

  final _formKey = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Add new class',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'year',
                    decoration: const InputDecoration(
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
                    clearIcon: const Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _year
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year, style: const TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'branch',
                    decoration: const InputDecoration(
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
                    clearIcon: const Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _branch
                        .map((branch) => DropdownMenuItem(
                              value: branch,
                              child: Text(branch, style: const TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormBuilderDropdown(
                    name: 'subject',
                    decoration: const InputDecoration(
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
                    clearIcon: const Icon(Icons.close, color: Colors.white,),
                    // hint: Text('Select Subject'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _subject
                        .map((subject) => DropdownMenuItem(
                              value: subject,
                              child: Text(subject, style: const TextStyle(color: Colors.white),),
                            ))
                        .toList(),
                  ),
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
                      "Add class",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print(_formKey.currentState!.fields["subject"]!.value);
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
