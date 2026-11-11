import 'package:chatapp/services/auth/LoginorRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/pages/HomePage.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              return Homepage();

            }
            else {
              return const Loginorregister();
            }
          
        },
      ),
    );
  }
}