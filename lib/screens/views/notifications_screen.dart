import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/notification.dart';
import '../../services/db_helper.dart';
import '../../services/retrofit_notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

 State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>{

  bool _useLocalDatabase = false;

  @override
  void initState() {
    super.initState();
    checkIfApiReachable();
  }

  Future<void> checkIfApiReachable() async {
    try {
     // const url = 'https://f4be-2c0f-f0f8-21c-6b00-320f-4a8-dfcd-255d.eu.ngrok.io/api';
      const url = 'https://a44c-2c0f-f0f8-21c-6b00-a737-d297-8ac0-58bc.eu.ngrok.io/api';
      final response = await Dio().get(url);
      setState(() {
        _useLocalDatabase = response.statusCode == 200 ? false : true;
      });
    } catch (e) {
      print("Exception: $e");
      setState(() {
        _useLocalDatabase = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(200,2,0,0),
        centerTitle: true,
        title: const Text("Notifications"),
      ),
      body: _useLocalDatabase
          ? showList(context, UserDatabaseHelper.getAllNotifications())
          : showList(context, ApiService(Dio(BaseOptions(contentType: 'application/json'))).getNotifications()),
    );
  }


  showList(BuildContext context, Future<List<MyNotification>?> future){
    return FutureBuilder<List<MyNotification>?>(
      future: future, //UserDatabaseHelper.getAllNotifications(),
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
                            child: Container(
                              height: 17,
                              width: 18,
                              child: Image.asset('icons/notification.png'),
                            ),
                            //Icon(Icons.notifications_outlined, size: 25),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(200, 200, 200, 200)),
                          ),

                          Expanded(

                            child: Text(
                              "${notifications?[index].message}",
                            ),

                          ),
                          Text("${notifications?[index].hour} : ${notifications?[index].minute}"),
                        ],
                      ),);

                  });
          }
        }

        return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,) );
      },
    );
  }
}