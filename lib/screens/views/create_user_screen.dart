import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usermanagement/screens/root_screen.dart';
import 'package:usermanagement/services/ChecKConnection.dart';
import 'package:usermanagement/services/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/form_component.dart';
import '../../models/notification.dart';
import '../../models/user.dart';
import '../../services/retrofit_service.dart';

class CreateUserScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final formkey = GlobalKey<FormState>();
  User? user;

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _agefocusNode = FocusNode();

  final  firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final ageController = TextEditingController();

  final isApiReachable = IsApiReachable.checkIfApiReachable();

  void _showSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Submitting form"),duration: Duration(seconds: 1),)
    );
  }

  static void goToUsersList(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RootScreen()));
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        leading: Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.all(10),
          child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.west_outlined,color: Colors.black,size: 15,)
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(200,2,0,0),
        title: const Text("Create profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20.0,
          ),
          Container(
            height: 128,
            width: 128,
            child: Container(
              width:54,height: 51,
              child: Image.asset('icons/userc.png',color: Colors.black,),
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 218, 220, 224),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child:Row(
                      children: [
                        Text(
                          "First name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15.0,),
                        Icon(Icons.circle, color: Colors.red, size: 5,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                   controller: firstnameController,
                    decoration: const InputDecoration(
                        hintText: "Prenom",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),

                    ),
                    focusNode: _firstNameFocusNode,
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value!)){
                        return "Enter correct firstname";
                      }{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child:Row(
                      children: [
                        Text(
                          "Last name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15.0,),
                        Icon(Icons.circle, color: Colors.red, size: 5,)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: lastnameController,
                    decoration: const InputDecoration(
                        hintText: "Nom",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    focusNode: _lastNameFocusNode,
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value!)){
                        return "Enter correct lastname";
                      }{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child:Row(
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                        hintText: "Age",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                    ),
                    focusNode: _agefocusNode,
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^(?:[0-9]|[1-9][0-9]|1[0-4][0-9]|150)$').hasMatch(value!)){
                        return "Enter correct age";
                      }{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: SizedBox(
                      width: FormComponent.screen_width(context),
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(formkey.currentState!.validate()){
                            _showSnackBar(context);
                          }

                          final firstname = firstnameController.value.text;
                          final lastname = lastnameController.value.text;
                          final age = ageController.value.text;

                          if(firstname.isEmpty || lastname.isEmpty || age.isEmpty){
                            return;
                          }

                          final User model = User(id: null, firstname: firstname, lastname: lastname, age: int.parse(age));
                          MyNotification notification = MyNotification(message: "${lastname} created", hour: DateTime.now().hour, minute: DateTime.now().minute);
                          if(user == null){
                            try{
                              if(await isApiReachable){
                                //for api
                                await UserDatabaseHelper.createUser(model);
                                ApiService(Dio(BaseOptions(contentType: "application/json"))).createUser(model);
                                try{
                                  await UserDatabaseHelper.createNotification(notification);
                                }catch(e){
                                  print("Une exception s'est produite : $e");
                                }
                                goToUsersList(context);
                              }else{
                                //for local
                                int result =await UserDatabaseHelper.createUser(model);
                                if(result != null || result > 0){
                                  await Fluttertoast.showToast(
                                    msg: "Utilisateur cree",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.greenAccent,
                                  );

                                  try{
                                    await UserDatabaseHelper.createNotification(notification);
                                  }catch(e){
                                    print("Une exception s'est produite : $e");
                                  }

                                  goToUsersList(context);
                                }else{
                                  await Fluttertoast.showToast(
                                    msg: "Requete echoue",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.redAccent,
                                  );
                                }

                              }

                            }catch(e){
                              print("Une exception s'est produite : $e");
                           }
                          }
                        },
                        child: Text("Save"),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                      ),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}