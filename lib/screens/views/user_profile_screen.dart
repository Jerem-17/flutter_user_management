import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usermanagement/components/form_component.dart';
import 'package:usermanagement/models/notification.dart';
import 'package:usermanagement/models/user.dart';
import 'package:usermanagement/screens/views/edit_user_screen.dart';

import '../../components/popup_component.dart';
import '../../services/db_notification_helper.dart';
import '../../services/db_user_helper.dart';
import 'create_user_screen.dart';

class UserProfileScreen extends StatelessWidget {

  final User user;


   const UserProfileScreen(this.user,{Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 2, 0, 0),
        title: const Text("User profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),

            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 250,
              decoration: BoxDecoration(
                color: Color.fromARGB(200, 236, 236, 239),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(200, 200, 200, 200),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Text('${user.firstname} ${user.lastname}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                  ),
                  Text('${user.age} y/o'),


                ],
              ),
            ),

            SizedBox(height: 100,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                width: FormComponent.screen_width(context),
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserScreen(user)));
                  },
                  child:Text('Edit profil'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),

                ),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                width: FormComponent.screen_width(context),
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Delete user?', textAlign: TextAlign.center,),
                          contentPadding: EdgeInsets.zero,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),

                              child: Column(
                                children: [
                                  SizedBox(height: 15.0,),
                                  Text('The user and their data will be deleted. Do you want to proceed?', textAlign: TextAlign.center,),

                                  SizedBox(height: 15.0,),

                                  Align(
                                      alignment: Alignment.center,
                                      child: Wrap(
                                          children: [
                                            SizedBox(
                                              width: 120.0,
                                              child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("No", style: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                                      200, 196, 191, 191)),

                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),

                                            SizedBox(
                                              width: 120.0,
                                              child: ElevatedButton(
                                                onPressed: () async{
                                                  User model = User(id: user?.id, firstname: user.firstname, lastname: user.lastname, age: user.age);
                                                    if(user != null){
                                                      int? user_id = await UserDatabaseHelper.getUserIdByUsername(user.lastname);
                                                      String username = user.lastname;
                                                      try{
                                                        int result =await UserDatabaseHelper.deleteUser(model);
                                                        if(result != null || result > 0){
                                                          await Fluttertoast.showToast(
                                                            msg: "Suppression effectue",
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            backgroundColor: Colors.greenAccent,
                                                          );
                                                          print(user_id);
                                                          MyNotification notification = MyNotification(username: username, message: "removed", hour: DateTime.now().hour, minute: DateTime.now().minute);
                                                          try{
                                                            await NotificationDatabaseHelper.createNotification(notification);
                                                          }catch(e){
                                                            print("Une exception s'est produite : $e");
                                                          }

                                                          CreateUserScreen.goToUsersList(context);
                                                        }else{
                                                          await Fluttertoast.showToast(
                                                            msg: "Requete echoue",
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            backgroundColor: Colors.redAccent,
                                                          );
                                                        }
                                                      }catch(e){
                                                        print("Une exception s'est produite : $e");
                                                      }
                                                    }
                                                },
                                                child: Text("Yes"),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.black),

                                                ),
                                              ),
                                            ),


                                          ]
                                      )
                                  ),
                                ],
                              ),
                            ),

                          ],
                        );
                      }
                    );
                  },
                  child:Text(
                      'Delete profil',
                      style: TextStyle(
                          color: Colors.black
                      )
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),

                  ),

                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  //  _showDialog(BuildContext context) {
  //
  // }
}