import 'package:class_appp/screens/slides_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Widgets/internet_connection_checker.dart';


class MidAndFinalScreen extends StatefulWidget {
  final query;
  final nodeName;
  final id; // id is lab or theory
  final subject;
  const MidAndFinalScreen({
    super.key,
    required this.query,
    required this.nodeName,
    required this.id,
    required this.subject
  });
  @override
  State<MidAndFinalScreen> createState() => _MidAndFinalScreenState(query:query, nodeName: nodeName, id: id, subject: subject);
}
class _MidAndFinalScreenState extends State<MidAndFinalScreen> {

  DatabaseReference query;
  final nodeName;
  final id;
  final subject;
  _MidAndFinalScreenState({required this.query, this.nodeName, this.id, this.subject});
  @override
  Widget build(BuildContext context) {
    query = query.child(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(nodeName),
      ),
      body: StreamBuilder(
        stream: query.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent>snapshot) {
          if(snapshot.hasData){
            var list = snapshot.data!.snapshot.children.toList();
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                String name = list[index].child('name').value as String;
                String id = list[index].child('id').value as String;
                if(name == nodeName.toString().toLowerCase() || name == id){
                  return Container();
                }
                else {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SlidesScreen(name: name, query : query, id : id.toString()),));
                    },
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(name,
                          style: const TextStyle(fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
