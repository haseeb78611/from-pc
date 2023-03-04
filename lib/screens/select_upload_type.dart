import 'package:class_appp/screens/add_class_work_screen.dart';
import 'package:class_appp/screens/create_nodes_screen.dart';
import 'package:class_appp/screens/upload_outline_screen.dart';
import 'package:class_appp/screens/upload_slides_screen.dart';
import 'package:flutter/material.dart';
class SelectUploadType extends StatefulWidget {
  const SelectUploadType({Key? key}) : super(key: key);

  @override
  State<SelectUploadType> createState() => _SelectUploadTypeState();
}

class _SelectUploadTypeState extends State<SelectUploadType> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Choose')
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
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UploadClassWorkScreen(),));},
                        child: Container(
                          width: 130,
                          child: Card(
                              color: Color(0xff7f6000),
                              child: Column(
                                  children : [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Icon(Icons.add_box_outlined, size: 70, color: Colors.white,),
                                    ),
                                    Container(height: 2, color: Colors.white,),
                                    Padding( padding: EdgeInsets.symmetric(vertical: 10),child: Text('Class Work', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
                                  ]
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadSlidesScreen(),));
                        },
                        child: Container(
                          width: 130,
                          child: Card(
                              color: Color(0xff7f6000),
                              child: Column(
                                  children : [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Icon(Icons.add_box_outlined, size: 70, color: Colors.white,),
                                    ),

                                    Container(height: 2, color: Colors.white,),
                                    Padding( padding: EdgeInsets.symmetric(vertical: 10),child: Text('Slides', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
                                  ]
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNodesScreen(),));},
            child: Container(
              width: 130,
              child: Card(
                  color: Color(0xff7f6000),
                  child: Column(
                      children : [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Icon(Icons.add_box_outlined, size: 70, color: Colors.white,),
                        ),
                        Container(height: 2, color: Colors.white,),
                        Padding( padding: EdgeInsets.symmetric(vertical: 10),child: Text('Create Node', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
                      ]
                  )
              ),
            ),
          ),
                        InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UploadOutlineScreen(),));},
                          child: Container(
                            width: 130,
                            child: Card(
                                color: Color(0xff7f6000),
                                child: Column(
                                    children : [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Icon(Icons.add_box_outlined, size: 70, color: Colors.white,),
                                      ),
                                      Container(height: 2, color: Colors.white,),
                                      Padding( padding: EdgeInsets.symmetric(vertical: 10),child: Text('Outline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
                                    ]
                                )
                            ),
                          ),
                        ),]
                  )
                ]
            ),
          ),
        )
    );
  }
}
