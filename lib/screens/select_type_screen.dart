// class work and slides selector Screen 2nd Screen
import 'package:class_appp/screens/subject_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Widgets/internet_connection_checker.dart';

class SelectTypeScreen extends StatefulWidget {
  final String semester;

  SelectTypeScreen({
    required this.semester
  });

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState(semester: semester);
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  final String semester;
  _SelectTypeScreenState({required this.semester});
  final database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(semester),
        ),
        body: StreamBuilder(
          stream: database.ref('${semester}_semester').child('types').onValue,
          builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
            if(snapshot.hasData){
              // Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
              // List<dynamic> list = [];
              // list.clear();
              // list = map.values.toList();
              var list = snapshot.data!.snapshot.children.toList();
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: /*snapshot.data!.snapshot.children.length*/ list.length,
                itemBuilder: (context, index) {
                  String name = list[index].child('name').value as String;
                  String id = list[index].child('id').value as String;
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectsScreen(semester: semester, classWorkId: id, name: name,),));
                    },
                    child: Card(
                      color: Colors.blue,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(name, style: TextStyle(fontSize: 30, color: Colors.white),),
                      )),
                    ),
                  );
                },);
            }
            else{
              return StreamBuilder<ConnectivityResult>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.active){
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return Center(child: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined, size: 200, color: Colors.black,));
                    }
                  }
              );
            }


          },
        )
    );
  }
}
