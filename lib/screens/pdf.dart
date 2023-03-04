import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Widgets/alert_dialog_ok_button.dart';
import '../Widgets/internet_connection_alert_dialog.dart';

class PDf extends StatefulWidget {
  final path;
  final name;
  const PDf({super.key,  this.path,  this.name});
  @override
  State<PDf> createState() => _PDfState(path : path, name: name);
}

class _PDfState extends State<PDf> {
  final path;
  final name;
  _PDfState({this.name,this.path});

  bool loading = true;

  loadDocument() async {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: Center(
        child:
            loading ?
                const CircularProgressIndicator()
            :
                SfPdfViewer.network(
                    path,
                  onDocumentLoadFailed: (details) {
                    Navigator.pop(context);
                    showDialog(context: context, builder: (context) {
                      return StreamBuilder<ConnectivityResult>(
                        stream: Connectivity().onConnectivityChanged,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(details.error, style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontFamily: 'ShantellSans',
                                      fontWeight: FontWeight.bold),)),
                              content: Container(
                                height: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.error, size: 100,
                                        color: Colors.red,),
                                      Center(child: Text(details.description)),
                                    ]
                                ),
                              ),
                              actions: [
                                Center(
                                    child: Widgets(context).okButtonWidget()
                                )
                              ],
                            );
                          }
                          else {
                            return InternetAlertDialog();
                          }
                        },
                      );
                    },);

                  }


                )
      )

    );
  }
}
