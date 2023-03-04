import 'package:class_appp/screens/mid_and_final_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Widgets/internet_connection_checker.dart';


class LabAndTheoryScreen extends StatefulWidget {
  final semester;
  final subject;
  final slidesId;


  LabAndTheoryScreen({
    required this.semester,
    required this.subject,
    required this.slidesId
  });

  @override
  State<LabAndTheoryScreen> createState() => _LabAndTheoryScreenState(semester: semester, subject: subject, slidesId: slidesId);
}

class _LabAndTheoryScreenState extends State<LabAndTheoryScreen> {

  final semester;
  final subject;
  final slidesId;
  _LabAndTheoryScreenState({this.semester, this.subject, this.slidesId});

  final database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var query = database.ref('${semester}_semester').child('types').child(slidesId)
        .child('subjects').child(subject);
    return Scaffold(
        appBar: AppBar(
          title: Text(subject),
        ),
        body: StreamBuilder(
          stream: query.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent>snapshot) {
            if(snapshot.hasData){
              var list = snapshot.data!.snapshot.children.toList();
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  String nodeName = list[index].child('name').value as String;
                  String id = list[index].child('id').value as String;
                  if(nodeName == subject.toString()){
                    return Container();
                  }else {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => MidAndFinalScreen(query:query, nodeName: nodeName, id: id.toString(), subject: subject,),));
                      },
                      child: Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(nodeName,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
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
