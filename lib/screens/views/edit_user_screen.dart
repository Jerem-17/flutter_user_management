import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usermanagement/components/popup_component.dart';
import 'package:usermanagement/models/user.dart';
import 'package:usermanagement/screens/views/create_user_screen.dart';

import '../../components/form_component.dart';
import '../../services/db_user_helper.dart';

class EditUserScreen extends StatelessWidget {
  final User user ;
  final formkey = GlobalKey<FormState>();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  EditUserScreen(this.user,{super.key})
   : firstnameController = TextEditingController(text: user.firstname),
     lastnameController = TextEditingController(text: user.lastname),
     ageController = TextEditingController(text: '${user.age}');

  void _showSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Submitting form"),duration: Duration(seconds: 1),)
    );
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200,2,0,0),
        title: const Text("Edit profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20.0,
          ),
          Container(
            height: 150.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(200, 200, 200, 200),
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
                    child: Text(
                      "First name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(

                    controller: firstnameController,
                    validator: (value) {
                      if(value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value!)){
                        return "Enter correct firstname";
                      }{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Last name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(

                    controller: lastnameController,
                    validator: (value) {
                      if(value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value!)){
                        return "Enter correct lastname";
                      }{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Age",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(

                    controller: ageController,
                    validator: (value) {
                      if(value!.isEmpty || !RegExp(r'^(?:[0-9]|[1-9][0-9]|1[0-4][0-9]|150)$').hasMatch(value!)){
                        return "Enter correct age";
                      }{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                        onPressed: (){

                          if(formkey.currentState!.validate()){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: Text('Save changes ?', textAlign: TextAlign.center,),
                                    contentPadding: EdgeInsets.zero,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),

                                        child: Column(
                                          children: [
                                            SizedBox(height: 15.0,),
                                            Text('The modifications you made will update the data', textAlign: TextAlign.center,),

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
                                                          child: Text("Cancel", style: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),),
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
                                                            if(formkey.currentState!.validate()){
                                                              _showSnackBar(context);
                                                            }

                                                            final firstname = firstnameController.value.text;
                                                            final lastname = lastnameController.value.text;
                                                            final age = ageController.value.text;

                                                            if(firstname.isEmpty || lastname.isEmpty || age.isEmpty){
                                                              return;
                                                            }

                                                            final User model = User(id: user?.id, firstname: firstname, lastname: lastname, age: int.parse(age));
                                                            if(user != null){
                                                              try{
                                                                int result =await UserDatabaseHelper.updateUser(model);
                                                                if(result != null || result > 0){
                                                                  await Fluttertoast.showToast(
                                                                    msg: "Utilisateur mis a jour",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.BOTTOM,
                                                                    backgroundColor: Colors.greenAccent,
                                                                  );
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
                                                          child: Text("Save"),
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
                                  );}
                            );
                          }
                          },
                        child: Text("Save changes"),
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