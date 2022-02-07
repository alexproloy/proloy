import 'package:flutter/material.dart';
import 'package:proloy/const/appcolor.dart';
import 'package:proloy/navigator/addtocart.dart';
import 'package:proloy/navigator/favorit.dart';
import 'package:proloy/navigator/homepage.dart';
import 'package:proloy/navigator/profile.dart';

class Homewidget extends StatefulWidget {
  const Homewidget({ Key? key }) : super(key: key);

  @override
  _HomewidgetState createState() => _HomewidgetState();
}

class _HomewidgetState extends State<Homewidget> {
  @override
  var indexpage = 0;
  final Page = [
    Homepage(),
    Favoritewidget(),
    Cartwidget(),
    profilewidget(),
  ];
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor.mycolor,
          title: Text("E-Commerce"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: "Favorit"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ],
          onTap: (index){
            setState(() {
              indexpage = index;
            });
          },
          ),
          body: Page[indexpage],
      ),
    );
  }
}