// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kutikin/home/home_page.dart';
import 'package:kutikin/profil/profil_page.dart';
import 'package:kutikin/transaksi/transaksi_page.dart';

class LandingPage extends StatefulWidget {
  final String nav;

  const LandingPage({Key key, this.nav}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  final List<Widget> _container = [
    HomePage(),
    TransaksiPage(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.nav == '0') {
      _bottomNavCurrentIndex = 0;
    } else if (widget.nav == '1') {
      _bottomNavCurrentIndex = 1;
    } else if (widget.nav == '2') {
      _bottomNavCurrentIndex = 2;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                onTabChange: (index) {
                  setState(() {
                    _bottomNavCurrentIndex = index;
                  });
                },
                selectedIndex: _bottomNavCurrentIndex,
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue,
                color: Colors.black, // navigation bar padding
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.shopping_cart_sharp,
                    text: 'Transaksi',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profil',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
