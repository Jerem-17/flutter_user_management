import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationListItemWidget extends StatefulWidget {
  const NotificationListItemWidget({super.key});

  State<NotificationListItemWidget> createState() =>
      _NotificationListItemWidgetState();
}

class _NotificationListItemWidgetState
    extends State<NotificationListItemWidget> {


  @override
  Widget build(BuildContext context) {
    List<MyNotification> notifications = [
      MyNotification(
          username: 'test',
          message: "removed",
          hour: 2,
          minute: 12)
    ];

    return ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
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
                    "${notifications[index].username} ${notifications[index].message}",
                  ),
                ),
                Text(
                    "${notifications[index].hour} : ${notifications[index].minute}"),
              ],
            ),
          );
        });
  }
}
