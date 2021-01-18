import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("My First App")),
          body: 
          Column(children: [
              SizedBox(height: 35.0,),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Login", 
                    style: TextStyle(fontSize: 24)
                  ),
              ),
              Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      children: [
                      TextFormField( 
                          keyboardType:  TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize:  14.0
                            ),),
                        ),
                        TextFormField( 
                          keyboardType:  TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize:  14.0
                            ),),
                        )
                    ],)
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: (){
                    print("Clicked");
                  },
                  child: Text("Login")
                )
                )
                 

            
         
 
              
           ],),
      )
      );

  }
}

 