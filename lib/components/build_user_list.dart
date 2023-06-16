import 'package:flutter/material.dart';
import 'package:usermanagement/screens/views/user_profile_screen.dart';

import '../models/user.dart';

class UserListItemWidget extends StatefulWidget {
  const UserListItemWidget({super.key});

  State<UserListItemWidget> createState() => _UserListItemWidgetState();
}


class _UserListItemWidgetState extends State<UserListItemWidget> {


  @override
  Widget build(BuildContext context) {

    List<User> users = [
      User(id: 1, firstname: "Sylvain", lastname: "TIASSOU", age: 17),
      User(id: 2, firstname: "Sarah", lastname: "AGNAVE", age: 16),
      User(id: 3, firstname: "Samuel", lastname: "KOFFI", age: 14),
      User(id: 4, firstname: "Nahomi", lastname: "PANDI", age: 10),
      User(id: 4, firstname: "Arobase", lastname: "HASHTAG", age: 18),
    ];

    return
      ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return  GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(users[index])));
                },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    child: Icon(Icons.perm_identity, size: 40),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(200, 200, 200, 200)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "${users[index].firstname} ${users[index].lastname}",
                          ),
                        ),
                        Text(
                          '${users[index].age}',
                        )
                      ],
                    ),
                  )
                ],
              )
          );
        });

  }


}