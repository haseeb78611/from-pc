import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  const InternetConnectionWidget({
    Key? key,
    required this.snapshot,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(snapshot.connectionState){
      case  ConnectionState.active :
        return  Center(child: CircularProgressIndicator(strokeWidth: 50,));
      default:
        return Scaffold(
          backgroundColor: Colors.blue,
          body: Center(child: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined, size: 200, color: Colors.white60,)),
        );
    }
  }
}
