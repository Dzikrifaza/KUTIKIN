// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches

import 'package:flutter/material.dart';
import 'package:kutikin/konstant.dart';
import 'package:kutikin/login_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController telp = TextEditingController();
  bool _isObpass = true;
  bool _isObcpass = true;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _createAccount() async {
    String params = '/CodeIgniter3/register';
    var url = Uri.http(sUrl, params);
    Map<String, String> body = {
      "userid": user.text,
      "telp": telp.text,
      "pass": pass.text
    };
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        if (response.body == "OK") {
          _scaffold.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Registration Success",
                style: TextStyle(color: Colors.black)),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
          ));
          setState(() {
            user.text = "";
            telp.text = "";
            pass.text = "";
            cpass.text = "";
          });
        } else {
          _scaffold.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Registration Gagal",
                style: TextStyle(color: Colors.black)),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
          ));
          setState(() {
            user.text = "";
            telp.text = "";
            pass.text = "";
            cpass.text = "";
          });
        }
      }
    } catch (e) {}
    return params;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffold,
        body: SingleChildScrollView(
          // reverse: true,
          child: Container(
              height: size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[800], Colors.blue[400]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 60, bottom: 20),
                    child: Text(
                      "KUTIK-IN",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Mari Kita Mulai Dengan Mendaftar",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Form(
                            key: _form,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: user,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        hintText: "Hanya Contoh",
                                        labelText: 'Nama Lengkap',
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        prefixIcon: Icon(Icons.person,
                                            color: Colors.blue),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Nama Lengkap cannot be empty';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: telp,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'telphone cannot be empty';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        hintText: "08xxxxxxxxxxxx",
                                        labelText: 'Telp',
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        prefixIcon: Icon(Icons.call,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
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
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        hintText: "Password",
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.blue),
                                        suffixIcon: IconButton(
                                          icon: _isObpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.blue,
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
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: cpass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Confirm password cannot be empty';
                                        } else if (text != pass.text) {
                                          return "Password doesn't match";
                                        }
                                      },
                                      obscureText: _isObcpass,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        )),
                                        hintText: "Confirm Password",
                                        labelText: 'Confirm Password',
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.blue),
                                        suffixIcon: IconButton(
                                          icon: _isObcpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.blue,
                                                ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                _isObcpass = !_isObcpass;
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

                                  // NOTE: BUTTON REGISTER
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final isValid =
                                              _form.currentState.validate();
                                          if (!isValid) {
                                            return;
                                          } else {
                                            _createAccount();
                                          }
                                        },
                                        child: Text('Register',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Sudah Punya Akun?",
                                          style: TextStyle(fontSize: 18)),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        },
                                        child: Text(" Masuk",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
