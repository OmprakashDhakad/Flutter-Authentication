import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';
import 'signupPage.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("Login"))),
        body: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Form(
                key: _formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print(passController.text);

                          try {
                            if (_formkey.currentState.validate()) {
                              await loginUser().then((jwt) {
                                print(jwt);
                                if (jwt['token'] != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );
                                  print("Successful");
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyLoginPage()),
                                  );
                                  print("Wrong Credentials");
                                }
                              });
                            } else {
                              print("Unsuccessfull");
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          child: Text(
                            "Create an Account!",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySignUpPage()),
                            );
                          })
                    ]))));
  }

  loginUser() async {
    String apiURL = "<login api here>";
    //json maping user entered details
    Map mapData = {
      'email': emailController.text,
      'password': passController.text,
    };
    String data = json.encode(mapData);
    //send  data using http
    print(mapData);
    var reponse = await http.post(
      Uri.parse(apiURL),
      body: data,
      headers: {"Content-Type": "application/json"},
    );
    //getting response from node backend
    //print(response);
    var dataresult = jsonDecode(reponse.body);

    return dataresult;
  }
}
