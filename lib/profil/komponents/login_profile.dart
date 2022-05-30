// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kutikin/edit/edit_page.dart';
import 'package:kutikin/landing_page.dart';
import 'package:kutikin/profil/komponents/build_button.dart';
import 'package:kutikin/profil/komponents/image_with_icon.dart';
import 'package:kutikin/profil/komponents/tutorial_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginProfile extends StatefulWidget {
  final String userid, nama;
  const LoginProfile({Key key, this.userid, this.nama}) : super(key: key);

  @override
  State<LoginProfile> createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWithIcon(),
          SizedBox(height: 15),
          Text(
            "Hi, " + widget.nama,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          SizedBox(height: 15),
          BuildButton(
            title: "Edit Profil",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditPage(
                        userid: widget.userid,
                      )));
            },
          ),
          SizedBox(height: 10),
          BuildButton(
            title: "Tutorial",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TutorialPage()));
            },
          ),
          SizedBox(height: 10),
          BuildButton(
            title: "Pusat Bantuan",
            press: () => launch("tel://21213123123"),
          ),
          SizedBox(height: 10),
          BuildButton(
            title: "Logout",
            press: _logout,
          ),
        ],
      ),
    );
  }
}
