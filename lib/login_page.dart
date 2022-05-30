// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kutikin/helper/dbhelper.dart';
import 'package:kutikin/konstant.dart';
import 'package:kutikin/register_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:websafe_svg/websafe_svg.dart';

class LoginPage extends StatefulWidget {
  final String nav;
  const LoginPage({Key key, this.nav}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isObpass = true;
  DbHelper dbHelper = DbHelper();

  _updateKeranjang(String userid) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set userid=?', [userid]);
    await batch.commit();
  }

  _showAlertDialog(BuildContext context, String e) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  _login() async {
    final prefs = await SharedPreferences.getInstance();
    var params = "/CodeIgniter3/login";
    var url =
        Uri.http(sUrl, params, {"username": user.text, "password": pass.text});
    var res = await http.get(url);
    if (res.statusCode == 200) {
      print(url);
      var response = json.decode(res.body);
      if (response['response_status'] == 'OK' &&
          response['data'][0]['level'] == '3') {
        prefs.setBool('login', true);
        prefs.setString('username', response['data'][0]['username']);
        prefs.setString('nama', response['data'][0]['nama']);
        if (widget.nav == "") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/landingusers', (route) => false);
        } else {
          _updateKeranjang(response['data'][0]['username']);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/keranjangusers', (route) => false);
        }
      } else {
        _showAlertDialog(context, response['response_message']);
        setState(() {
          user.text = "";
          pass.text = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // reverse: true,
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[800], Colors.blue[400]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Text(
                  "IKERUT",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text("Silahkan Masuk Terlebih Dahulu\n",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              WebsafeSvg.asset(
                'assets/images/login.svg',
                height: 200,
                width: 200,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              // Icon(Icons.image, size: 333, color: Colors.white),
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          controller: user,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            focusColor: Colors.white,
                            hintText: "08xxxxxxxxxxxx",
                            labelText: 'Telp',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Telp cannot be empty';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: pass,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'password cannot be empty';
                            } else if (text.length < 8) {
                              return "Enter valid password of more then 8 characters!";
                            }
                          },
                          obscureText: _isObpass,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            focusColor: Colors.white,
                            hintText: "Password",
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              icon: _isObpass
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                setState(
                                  () {
                                    _isObpass = !_isObpass;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // NOTE: BUTTON LOGIN
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              final isValid = _form.currentState.validate();
                              if (!isValid) {
                                return;
                              } else {
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) => LandingPage()));
                                _login();
                              }
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text(" Register",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                    ],
                  ))
            ],
          )),
    ));
  }
}
