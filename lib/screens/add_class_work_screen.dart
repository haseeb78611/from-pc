// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:class_appp/Widgets/cupertino_picker_button.dart';
import 'package:class_appp/Widgets/text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/taost.dart';

class UploadClassWorkScreen extends StatefulWidget {
  const UploadClassWorkScreen({Key? key}) : super(key: key);

  @override
  State<UploadClassWorkScreen> createState() => _AddClassWorkScreenState();
}

class _AddClassWorkScreenState extends State<UploadClassWorkScreen> {

  final formKey = GlobalKey<FormState>();
  final classWorkController = TextEditingController();
  final dateController = TextEditingController();
  final deadlineController = TextEditingController();
  var timer = DateTime.now();
  var semester = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight'];
  //var semester = ['1st_semester', '2nd_semester', '3rd_semester', '4th_semester', '5th_semester', '6th_semester', '7th_semester', '8th_semester'];
  var semesterNode = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  var workType = ['Lab Assignment', 'Theory Assignment'];
  var subject;
  int semesterNumber = 0;
  int subjectNumber = 0;
  int workTypeNumber = 0;
  final database = FirebaseDatabase.instance;
  bool uploadTap = false;
  Map<dynamic, List<String>> subjects = {'oneSemester' : ['AC', 'CF', 'CPC', 'IS', 'PS'],
    'twoSemester': ['OOP', 'AP', 'BE', 'FE', 'LAAG'],
    'threeSemester' : ['WT', 'DLD', 'DSA', 'DBMS', 'DM'],
    'fourSemester' : ['soon'],
    'fiveSemester' : ['soon'],
    'sixSemester' : ['soon'],
    'sevenSemester' : ['soon'],
    'eightSemester' : ['soon']
  };




  @override
  void initState() {
    super.initState();
    timer = DateTime.now();
    dateController.text = timer.day.toString() + '/'+ timer.month.toString() + '/'+ timer.year.toString();
    deadlineController.text = 'Select';
     subject = subjects['${semester[semesterNumber]}Semester']!.toList();
  }
  uploadData(){
    timer = DateTime.now();
    String currentTime = timer.day.toString() + '-'+ timer.month.toString() + '-'+ timer.year.toString() + ' ${timer.hour}\:${timer.minute}\:${timer.millisecondsSinceEpoch}' ;
    // make semester id
     //database.ref(semesterNode[semesterNumber]).set({'semester': semesterNode[semesterNumber]});
    // // make class work id
    // database.ref(semesterNode[semesterNumber]).child('types').child('class_work').set({'name' : 'Class Work', 'id' : 'class_work'});
    //make subjects id
    //database.ref(semesterNode[semesterNumber]).child('types').child('class_work').child('subjects').child(subject[subjectNumber]).set({'name' : subject[subjectNumber].toString()});
    //finally update data
    database.ref(semesterNode[semesterNumber]+'_semester')
        .child('types')
        .child('class work')
        .child('subjects')
        .child(subject[subjectNumber])
        .child(currentTime)
    .set({
      'type' : workType[workTypeNumber],
      'work' : classWorkController.text.toString(),
      'time' : currentTime,
      'initial_date' : dateController.text.toString(),
      'deadline_date' : deadlineController.text.toString()
    })
    .then((value) {
      setState(() {
        classWorkController.text = '';
        deadlineController.text = '';
      });
      Toast().show('Successfully Uploaded');
    })
    .onError((error, stackTrace) {
      Toast().show(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Class Work'),
        ),
        body: Container(
          width: double.infinity,
          height : double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff7f6000),
                    Color(0xffefff00),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              )
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                    Form(
                      key: formKey,
                        child:Column(
                          children: [
                            MyTextField(
                              validatorMsg: 'Fill The Box',
                              controller : classWorkController,
                              hintText: 'Write Class Work',
                              maxLines:5,
                              onTap: (){

                              },
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              validatorMsg: 'Fill The Box',
                              controller : dateController,
                              suffixText: 'Initial',
                              onTap: ()async{
                                FocusScope.of(context).unfocus();
                                DateTime? datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2027)
                                );
                                if(datePicked != null){

                                  dateController.text = '${datePicked.day}/${datePicked.month}/${datePicked.year}';
                                }
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            SizedBox(height:10),
                            MyTextField(
                              onTap: ()async {
                                FocusScope.of(context).unfocus();
                                  DateTime? datePicked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2027),
                                  );
                                  if(datePicked!=null) {
                                    deadlineController.text = '${datePicked.day}/${datePicked.month}/${datePicked.year}' ;
                                  }
                                  FocusScope.of(context).unfocus();
                              },
                              validatorMsg: 'Fill The Box',
                              controller : deadlineController,
                              suffixText: 'Deadline',
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20),
                    CupertinoPickerButton(
                        child: Text(semesterNode[semesterNumber] + ' Semester'),
                      cupertinoPicker: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: semesterNumber),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            semesterNumber = value;
                            subjectNumber = 0;
                            subject = subjects['${semester[semesterNumber]}Semester']!.toList();
                          });
                        },
                        itemExtent: 50,
                        children:  [
                          for(String name in semesterNode)
                            Center(child: Text('$name Semester'),)
                        ],
                      ),
                    ),
                    const SizedBox(height:20),
                    CupertinoButton.filled(
                        child:  Text('${subject[subjectNumber]}'),
                        onPressed: (){
                          showCupertinoModalPopup(context: context, builder: (context) {
                            return Container(
                              color : Colors.yellow,
                              height: 250,
                              width: double.infinity,
                              child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: subjectNumber
                                  ),
                                  itemExtent: 50,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      subjectNumber = value;
                                    });
                                  },
                                  children:  [
                                    for(String name in subjects['${semester[semesterNumber]}Semester']!)
                                      Center(child: Text(name))
                                  ]
                              ),
                            );
                          },);
                        }),
                    const SizedBox(height:20),
                    CupertinoButton.filled(
                        child: Text(workType[workTypeNumber]),
                        onPressed: (){
                          showCupertinoModalPopup(context: context, builder: (context) {
                            return Container(
                              color: Colors.yellow,
                              height: 250,
                              width: double.infinity,
                              child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: workTypeNumber
                                  ),
                                  itemExtent: 50,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      workTypeNumber = value;
                                    });
                                  },
                                  children:  [
                                    Center(child: Text('Lab Assignment')),
                                    Center(child: Text('Theory Assignment')),
                                  ]
                              ),
                            );
                          },);
                        }),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            uploadData();
                          }

                    },
                        child: SizedBox(
                          width: 110,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_upward),
                                Text('UPLOAD', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                              ],
                            ),
                          ),
                        )
        ),

                  ]
              )
          ),
        ),
      ),
    );
  }
}
