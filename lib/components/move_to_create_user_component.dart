import 'package:flutter/material.dart';

import '../screens/views/create_user_screen.dart';


class MoveToCreateUserComponent extends StatelessWidget {
  const MoveToCreateUserComponent({Key? key}) : super(key: key);

  void _movetopage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateUserScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(200,2,0,0),
      onPressed: () => _movetopage(context),
      child: const Icon(
        Icons.create,
      ),
    );
  }
}