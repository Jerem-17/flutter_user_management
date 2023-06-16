import 'package:flutter/material.dart';
import 'package:usermanagement/screens/root_screen.dart';
import 'package:usermanagement/services/db_user_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/form_component.dart';
import '../../models/user.dart';

class CreateUserScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final formkey = GlobalKey<FormState>();
  User? user;

  final  firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final ageController = TextEditingController();

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
                    decoration: const InputDecoration(
                        hintText: "prenom",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                    child: Text(
                      "Last name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: lastnameController,
                    decoration: const InputDecoration(
                        hintText: "nom",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                    child: Text(
                      "Age",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                        hintText: "age",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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

                          final User model = User(id: user?.id, firstname: firstname, lastname: lastname, age: int.parse(age));

                          if(user == null){
                            try{
                              int result =await UserDatabaseHelper.createUser(model);
                              if(result != null || result > 0){
                                await Fluttertoast.showToast(
                                  msg: "Utilisateur cree",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.greenAccent,
                                );
                                goToUsersList(context);
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