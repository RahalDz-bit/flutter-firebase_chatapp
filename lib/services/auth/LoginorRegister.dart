import 'package:chatapp/pages/loginpage.dart';
import 'package:chatapp/pages/registerpage.dart';
import 'package:flutter/material.dart';

class Loginorregister extends StatefulWidget {
  const new({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {

  bool showLoginpage = true;
  // toggle
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return Loginpage(ontap: togglePages,);
    }
    else {
      return Registerpage(ontap: togglePages,);
    }
  }
}