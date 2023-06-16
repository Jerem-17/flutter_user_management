import 'package:flutter/material.dart';

class PopupDialogComponent extends StatelessWidget{
  dynamic action;
  String title , content, btn1text, btn2text ;


  PopupDialogComponent({Key? key,required this.title, required this.content, required this.btn1text,required this.btn2text,this.action});

  @override
  Widget build(BuildContext context){
    return SimpleDialog(
        title: Text('$title', textAlign: TextAlign.center,),
        contentPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),

            child: Column(
              children: [
                SizedBox(height: 15.0,),
                Text('$content', textAlign: TextAlign.center,),

                SizedBox(height: 15.0,),

                Align(
                    alignment: Alignment.center,
                    child: Wrap(
                        children: [
                          SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop;
                              },
                              child: Text(btn1text, style: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),),
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
                              onPressed: (){
                                action;
                              },
                              child: Text(btn2text),
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



}