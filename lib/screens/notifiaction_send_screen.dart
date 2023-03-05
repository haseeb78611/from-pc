
import 'package:flutter/material.dart';

import '../Services/local_notification_service.dart';
class NotificationSend extends StatefulWidget {
  const NotificationSend({Key? key}) : super(key: key);

  @override
  State<NotificationSend> createState() => _NotificationSendState();
}

class _NotificationSendState extends State<NotificationSend> {
  late final  LocalNotificationServic service ;
  @override
  void initState() {
    service = LocalNotificationServic();
    service.initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Send"),
      ),
      body:Center(
          child: Container(
            child: Column(
              children: [
                TextButton(
                    onPressed: () async{
                     await  service.showNotification(id: 0, title: 'Notification', body: 'This is body');
                    },
                    child: Text('Send Notification', style: TextStyle(color: Colors.blue),)),
                TextButton(
                  onPressed: (){},
                  child: Text('Scheduled Notification', style: TextStyle(color: Colors.blue)),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text('Next Screen Notifiacation', style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
          )
      ),
    );
  }
}
