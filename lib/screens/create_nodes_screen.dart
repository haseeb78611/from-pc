

import 'package:class_appp/Services/taost.dart';
import 'package:class_appp/Widgets/button.dart';
import 'package:class_appp/Widgets/cupertino_picker_button.dart';
import 'package:class_appp/Widgets/text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNodesScreen extends StatefulWidget {
  const CreateNodesScreen({Key? key}) : super(key: key);

  @override
  State<CreateNodesScreen> createState() => _CreateNodesScreenState();
}

class _CreateNodesScreenState extends State<CreateNodesScreen> {

  var database = FirebaseDatabase.instance;
  var workTypeController = TextEditingController();
  var semesterController = TextEditingController();
  var subjectController = TextEditingController();

  Map<dynamic, List<String>> subjects = {
    'oneSemester' : ['AC', 'CF', 'CPC', 'IS', 'PS'],
    'twoSemester': ['OOP', 'AP', 'BE', 'FE', 'LAAG'],
    'threeSemester' : ['WT', 'DLD', 'DSA', 'DBMS', 'DM'],
    'fourSemester' : ['soon'],
    'fiveSemester' : ['soon'],
    'sixSemester' : ['soon'],
    'sevenSemester' : ['soon'],
    'eightSemester' : ['soon']
  };
  var materialTime = ['Mid', 'Final'];
  var semester = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight'];
  var types = ['Class Work', 'Slides', 'Outline'];
  var semesterNode = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  var materialType = ['Lab', 'Theory'];
  int materialTypeNumber = 0;
  int typesNumber = 0;
  int semesterNumber = 0;
  int subjectNumber = 0;
  int materialTimeNumber = 0;
  var subject;
  
  createSemesterNode(){
    database.ref().child(semesterNode[semesterNumber] + '_semester').set({
      'semester' : semesterNode[semesterNumber],
    }).then((value) {
      Toast().show('Successfuly Updated');
    }).onError((error, stackTrace) {
      Toast().show(error.toString());
    });
  }
  createTypeNode(){
    database.ref().child(semesterNode[semesterNumber]+'_semester').child('types')
        .child(types[typesNumber].toLowerCase()).set({
      'id' : types[typesNumber].toLowerCase(),
      'name' : types[typesNumber],
    }).then((value) {
      Toast().show('Successfuly Updated');
    }).onError((error, stackTrace) {
      Toast().show(error.toString());
    });
  }
  createSubjectNode(){
    database.ref().child(semesterNode[semesterNumber]+'_semester').child('types')
    .child(types[typesNumber].toLowerCase())
        .child('subjects')
        .child(subject[subjectNumber]).set({
      'name' : subject[subjectNumber]
    }).then((value) {
      Toast().show('Successfuly Updated');
    }).onError((error, stackTrace) {
      Toast().show(error.toString());
    });
  }
  createSlidesTypeTime(){
    var check = database.ref(semesterNode[semesterNumber]+'_semester').child('types');
    var node = check.child('slides')
    .child('subjects')
        .child(subject[subjectNumber])
    .set({
      'name' : subject[subjectNumber],
      //set Lab Node
      'lab' : {
        'id':'lab',
        'name' : 'Lab',
        //set Mid Node
        'mid' : {
          'id' : 'mid',
          'name' : 'Mid'
      },
        //set final node
        'final' : {
          'id' : 'final',
          'name' : 'Final'
        }
      },
      //set theroy node
      'theory' : {
        'id' : 'theory',
        'name' : 'Theory',
        //set mid node
        'mid' : {
          'id' : 'mid',
          'name' : 'Mid'
    },
        //set final node
        'final' : {
          'id' : 'final',
          'name' : 'Final'
        }
      }
    }).then((value) {
      Toast().show('Successfuly Updated');
    }).onError((error, stackTrace) {
      Toast().show(error.toString());
    });


  }

  @override
  void initState() {
    subject = subjects['${semester[semesterNumber]}Semester']!.toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Node'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            ),
            MyButton(
              width: 227,
              alignment: MainAxisAlignment.center,
              onPressed: (){
                createSemesterNode();
              },
              text: 'Create Semester Node',
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
                child:  Text('${types[typesNumber]}'),
                onPressed: (){
                  showCupertinoModalPopup(context: context, builder: (context) {
                    return Container(
                      color : Colors.yellow,
                      height: 250,
                      width: double.infinity,
                      child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                              initialItem: typesNumber
                          ),
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              typesNumber = value;
                            });
                          },
                          children:  [
                            for(String name in types)
                              Center(child: Text(name))
                          ]
                      ),
                    );
                  },);
                }),
            MyButton(
              alignment: MainAxisAlignment.center,
              onPressed: (){
               createTypeNode();
              },
              text: 'Create Type Node',
              width: 227,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            ),
            MyButton(
              width: 227,
                onPressed: (){
                createSubjectNode();
                },
                alignment: MainAxisAlignment.center,
              text: 'Create Subject Node',
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                    child:  Text('${materialTime[materialTimeNumber]}'),
                    onPressed: (){
                      showCupertinoModalPopup(context: context, builder: (context) {
                        return Container(
                          color : Colors.yellow,
                          height: 250,
                          width: double.infinity,
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: materialTimeNumber
                              ),
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  materialTimeNumber = value;
                                });
                              },
                              children:  [
                                for(String name in materialTime)
                                  Center(child: Text(name))
                              ]
                          ),
                        );
                      },);
                    }),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                    child:  Text('${materialType[materialTypeNumber]}'),
                    onPressed: (){
                      showCupertinoModalPopup(context: context, builder: (context) {
                        return Container(
                          color : Colors.yellow,
                          height: 250,
                          width: double.infinity,
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: materialTypeNumber
                              ),
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  materialTypeNumber = value;
                                });
                              },
                              children:  [
                                for(String name in materialType)
                                  Center(child: Text(name))
                              ]
                          ),
                        );
                      },);
                    }),
              ],
            ),
            MyButton(
              width: 279,
                onPressed: (){
                createSlidesTypeTime();
                },
                alignment: MainAxisAlignment.center,
              text: 'Create Slides Type and Time',
            )
          ],
        ),
      ),
    );
  }
}
