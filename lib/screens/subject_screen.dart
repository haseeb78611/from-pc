//3rd screen subjects shown screen
import 'package:class_appp/screens/class_work_screen.dart';
import 'package:class_appp/screens/lab_and_theory_screen.dart';
import 'package:class_appp/screens/slides_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';




class SubjectsScreen extends StatefulWidget {
  final String name;
  final String semester;
  final String classWorkId;

  SubjectsScreen({
    required this.classWorkId,
    required this.name,
    required this.semester
  });

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState(semester: semester, name: name,classWorkId: classWorkId);
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final String name;
  final String semester;
  final String classWorkId;
  _SubjectsScreenState({required this.semester, required this.name, required this.classWorkId});


  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final query = database.ref('${semester}_semester').child('types').child(classWorkId).child('subjects');
    return Scaffold(
      appBar: AppBar(
          title: Text(name)
      ),
      body: StreamBuilder(
        stream: query.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent>snapshot) {
          if(snapshot.hasData){
            var list = snapshot.data!.snapshot.children.toList();
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                String subject = list[index].child('name').value as String;
                return InkWell(
                  onTap: (){
                    switch(classWorkId) {
                      case 'class work':
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ClassWorkScreen(
                                semester: semester,
                                classWorkId: classWorkId,
                                subject: subject,)));
                        break;
                      case 'slides':
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LabAndTheoryScreen(
                            semester : semester,
                            slidesId : classWorkId,
                            subject: list[index]
                                .child('name').value.toString()
                        ),));
                        break;
                      case 'outline':
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SlidesScreen(
                          query: query,
                          name : subject,
                          id: subject,
                        ),));
                        break;
                    }
                  },
                  child: Card(
                    color:Colors.blue ,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Text(
                        list[index].child('name').value as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
                      ),
                    ),
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
      ),
    );
  }
}
