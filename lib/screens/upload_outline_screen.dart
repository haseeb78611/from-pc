import 'dart:io';

import 'package:class_appp/Services/taost.dart';
import 'package:class_appp/Widgets/button.dart';
import 'package:class_appp/Widgets/cupertino_picker_button.dart';
import 'package:class_appp/Widgets/text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadOutlineScreen extends StatefulWidget {
  const UploadOutlineScreen({Key? key}) : super(key: key);

  @override
  State<UploadOutlineScreen> createState() => _UploadOutlineScreenState();
}
class _UploadOutlineScreenState extends State<UploadOutlineScreen> {

  var database = FirebaseDatabase.instance;
  IconData fileUploadIcon = Icons.upload_file_outlined;
  FilePickerResult? fileResult;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  File? file;
  final fileNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance.ref();
  String? path;


  Map<dynamic, List<String>> subjects = {'oneSemester' : ['AC', 'CF', 'CPC', 'IS', 'PS'],
    'twoSemester': ['OOP', 'AP', 'BE', 'FE', 'LAAG'],
    'threeSemester' : ['WT', 'DLD', 'DSA', 'DBMS', 'DM'],
    'fourSemester' : ['soon'],
    'fiveSemester' : ['soon'],
    'sixSemester' : ['soon'],
    'sevenSemester' : ['soon'],
    'eightSemester' : ['soon']
  };
  var semesterNode = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  var semester = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight'];
  int subjectNumber = 0;
  var subject;
  int semesterNumber = 0;

  var timer = DateTime.now();


  @override
  void initState() {
    super.initState();

    subject = subjects['${semester[semesterNumber]}Semester']!.toList();
  }

  filePick() async {
    fileResult = await FilePicker.platform.pickFiles();
    pickedFile = fileResult!.files.single;
    file =  File(pickedFile!.path!);
    setState(() {
    });
  }
  uploadFile()async{
    path = 'outline/${semester[semesterNumber]}/${subject[subjectNumber]}/${fileNameController.text}.${pickedFile!.extension}';
    final task = storage.child(path!);
    uploadTask = task.putFile(file!);
    final snapshot = await uploadTask!.whenComplete((){
      print('when Complete');
    });
    final urls = await snapshot.ref.getDownloadURL();
    final url = await snapshot.ref.getDownloadURL().then((value) {
      Toast().show('Succefully Uploaded');
      print('uploaded file');
      timer = DateTime.now();
      String currentTime = timer.day.toString() + '-'+ timer.month.toString() + '-'+ timer.year.toString() + ' ${timer.hour}\:${timer.minute}\:${timer.millisecondsSinceEpoch}' ;
      database.ref(semesterNode[semesterNumber] + '_semester')
          .child('types')
          .child('outline')
          .child('subjects')
          .child(subject[subjectNumber])
          .child(currentTime).set({
        'time' : currentTime,
        'name' : fileNameController.text,
        'url' : urls.toString(),
      }).then((value) {
        Toast().show('Realtime Uplaoded');
      }).onError((error, stackTrace) {
        Toast().show(error.toString());
      });
    });



  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        formKey.currentState!.validate();
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text('Upload Outline')
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
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  child: Column(
                    children: [
                      (file==null) ?
                      InkWell(
                          onTap: (){
                            filePick();
                          },
                          child: Icon(Icons.upload_file_outlined, size: 150,))
                          : InkWell(
                          onTap: (){
                            filePick();
                          },
                          child: Icon(Icons.file_copy, size: 150,)),
                      SizedBox(height: 30,),
                      Form(
                        key: formKey,
                        child: MyTextField(
                          controller: fileNameController,
                          hintText: 'File Name',
                          validatorMsg: 'Enter File Name',
                        ),
                      ),
                      SizedBox(height: 30,),
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

                      MyButton(onPressed: (){
                        if(formKey.currentState!.validate()){
                          uploadFile();
                        }
                      },
                        alignment: MainAxisAlignment.center,
                        icon: Icons.arrow_upward,
                        text: 'UPLOAD',
                      )
                    ],
                  ),
                ),
              )
          )
      ),
    );
  }
}
