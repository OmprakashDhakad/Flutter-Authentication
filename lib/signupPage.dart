import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'loginPage.dart';

class MySignUpPage extends StatefulWidget {
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("SignUp"))),
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
                        controller: fullnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                          try {
                            if (_formkey.currentState.validate()) {
                              await registrationUser().then((val) {
                                print(val);
                              });
                              print("Successful");
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
                            "Have an Account ?",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLoginPage()),
                            );
                          })
                    ]))));
  }

  registrationUser() async {
    String apiURL = "<registration api>";
    //json maping user entered details
    Map mapData = {
      'fullname': fullnameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': passController.text,
    };
    String data = json.encode(mapData);
    //send  data using http post
    print(mapData);
    var reponse = await http.post(
      Uri.parse(apiURL),
      body: data,
      headers: {"Content-Type": "application/json"},
    );

    var dataresult = jsonDecode(reponse.body);

    return dataresult;
  }
}
