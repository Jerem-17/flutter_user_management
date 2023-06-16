import 'package:flutter/material.dart';
import 'package:usermanagement/components/build_user_list.dart';
import 'package:usermanagement/screens/views/user_profile_screen.dart';
import 'package:usermanagement/services/db_user_helper.dart';


import '../../components/move_to_create_user_component.dart';
import '../../models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Users"),
        backgroundColor: Color.fromARGB(200, 2, 0, 0),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>?>(
        future: UserDatabaseHelper.getAllUsers(),
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
                                        "${users![index].firstname} ${users[index].lastname}",
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

          return Center(child: CircularProgressIndicator() ,);

        },
      ),


      // UserListItemWidget(),
      floatingActionButton: const MoveToCreateUserComponent(),
    );
  }

  
  
}

