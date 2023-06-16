import 'package:flutter/material.dart';

import 'views/notifications_screen.dart';
import 'views/user_list_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List screens = [
    UsersScreen(),
    NotificationScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications,),
                //showicon(isVisited)
                Visibility(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Icon(Icons.circle, size: 10, color: Colors.red,),
                    ),
                    visible: true
                )
              ],
            ),
                label: 'notification'
            )
          ]),
    );
  }
}