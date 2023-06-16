import 'package:flutter/material.dart';

class FormComponent extends StatelessWidget {
  String btnName;
  dynamic action;
  FormComponent({Key? key, required this.btnName, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          key: GlobalKey(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "First name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              textFormField("prenom"),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Last name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              textFormField("nom"),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Age",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              textFormField("age"),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: SizedBox(
                    width: screen_width(context),
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: (){action;},
                      child: Text(btnName),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.black)),
                    ),
                  ))
            ],
          ),
        ),
      ]),
    );
  }

  static Widget textFormField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: (value) {
          //
        },
        decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }



  static double screen_width(BuildContext context)
  {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double screenWidth = screenSize.width;
    return screenWidth;
  }
}