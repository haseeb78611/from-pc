import 'package:class_appp/Widgets/alert_dialog_ok_button.dart';
import 'package:flutter/material.dart';

class InternetAlertDialog extends StatelessWidget {

  const InternetAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text('Error', style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontFamily: 'ShantellSans',
              fontWeight: FontWeight.bold),)),
      content: Container(
        height: 160,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined, size: 100,
                color: Colors.red,),
              Center(child: Text('Check Your Internet Connection')),
            ]
        ),
      ),
      actions: [
        Center(
          child: Widgets(context).okButtonWidget(),
        )
      ],
    );
  }
}
