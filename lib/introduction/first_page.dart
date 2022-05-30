// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kutikin/introduction/second_page.dart';
import 'package:kutikin/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool intro = false;
  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      intro = prefs.getBool('intro') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: intro ? IntroPage() : LandingPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Text(
              "KUTIK-IN",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Sayangi lingkungan dengan cara mengurangi penggunaan plastik dan isi ulang berbagai kebutuhan rumah tangga",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Icon(Icons.image, size: 333, color: Colors.white),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Selanjutnya",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
