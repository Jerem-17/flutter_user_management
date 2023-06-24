
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:usermanagement/screens/views/user_profile_screen.dart';
import 'package:usermanagement/services/db_helper.dart';

import '../../components/move_to_create_user_component.dart';
import '../../models/user.dart';
import '../../services/retrofit_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  bool _useLocalDatabase = false;

  @override
  void initState() {
    super.initState();
    checkIfApiReachable();
  }

  Future<void> checkIfApiReachable() async {
    try {
      //const url = 'https://f4be-2c0f-f0f8-21c-6b00-320f-4a8-dfcd-255d.eu.ngrok.io/api';
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
        title: const Text("Users"),
        backgroundColor: const Color.fromARGB(200, 2, 0, 0),
        centerTitle: true,
      ),
      body: _useLocalDatabase
          ? showList(context, UserDatabaseHelper.getAllUsers())
          : showList(context, ApiService(Dio(BaseOptions(contentType: 'application/json'))).getUsers()),
      floatingActionButton: const MoveToCreateUserComponent(),
    );
  }

  showList(BuildContext context, Future<List<User>?> future){
    return FutureBuilder<List<User>?>(
      future: future,
      builder: (context, AsyncSnapshot<List<User>?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: CircularProgressIndicator() ,);
        }else if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }else if(snapshot.hasData){
          if(snapshot.data != null){
            final users = snapshot.data;
            return
              ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                        onTap:() async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(users![index])));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              child: Container(
                                height: 17,
                                width: 18,
                                child: Image.asset('icons/user.png',color: Colors.black,),
                              ),
                              //Icon(UMIcons.user, size: 18),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(200, 200, 200, 200)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${users![index].firstname} ${users[index].lastname}",
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

        return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,) ,);

      },
    );
  }

  
  
}

