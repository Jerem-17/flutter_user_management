import 'package:flutter/material.dart';

import '../../components/build_notification_list.dart';
import '../../models/notification.dart';
import '../../services/db_notification_helper.dart';
import '../../services/db_user_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(200,2,0,0),
        centerTitle: true,
        title: const Text("Notifications"),
      ),
      body: FutureBuilder<List<MyNotification>?>(
        future: NotificationDatabaseHelper.getAllNotifications(),
        builder: (context, AsyncSnapshot<List<MyNotification>?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }else if(snapshot.hasData){
            if(snapshot.data != null){
              final notifications = snapshot.data;
              return
                ListView.builder(
                    itemCount: notifications?.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              child: Icon(Icons.notifications_outlined, size: 25),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(200, 200, 200, 200)),
                            ),

                            Expanded(

                              child: Text(
                                "${notifications?[index].username} ${notifications?[index].message}",
                              ),

                            ),
                            Text("${notifications?[index].hour} : ${notifications?[index].minute}"),
                          ],
                        ),);

                    });
            }
          }

          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}