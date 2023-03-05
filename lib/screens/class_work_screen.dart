//4th screen real class work
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class ClassWorkScreen extends StatefulWidget {
  final String subject;
  final String semester;
  final String classWorkId;
  ClassWorkScreen({
    required this.subject,
    required this.semester,
    required this.classWorkId
  });

  @override
  State<ClassWorkScreen> createState() => _ClassWorkScreenState(semester: semester, subject: subject, classWorkId: classWorkId);
}

class _ClassWorkScreenState extends State<ClassWorkScreen> {

  final String subject;
  final String semester;
  final String classWorkId;
  _ClassWorkScreenState({required this.semester, required this.subject, required this.classWorkId});

  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: StreamBuilder(
        //classWorkId is 2nd screen selection wheate=her its slides or class work
        stream: database.ref('${semester}_semester').child('types').child(classWorkId).child('subjects').child(subject).orderByChild('time').onValue,
        builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
          if(snapshot.hasData){
            var list = snapshot.data!.snapshot.children.toList();
            int counter = list.length;
            return ListView.builder(
              itemCount: list.length-1,
              itemBuilder: (context, index) {
                counter--;
                return Card(
                    color: Colors.blue,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(list[counter].child('type').value as String, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
                      subtitle: Container( margin : EdgeInsets.only(top: 10),child: Text(list[counter].child('work').value as String, style: TextStyle(fontWeight: FontWeight.bold),)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(onTap: (){
                            database.ref('${semester}_semester').child('types').child(classWorkId).child('subjects').child(subject).child(list[counter].child('time').value as String).remove();
                          },
                              child: Icon(Icons.delete)),
                          Text('Initial : ${list[counter].child('initial_date').value as String}', style: TextStyle(color: Colors.white),),
                          Text('Deadline : ${list[counter].child('deadline_date').value as String}', style: TextStyle(color: Colors.white) )
                        ],
                      ),
                    )
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
      ),
    );
  }
}
