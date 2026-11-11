import 'package:chatapp/services/auth/LoginorRegister.dart';
import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/firebase_options.dart';

import 'package:chatapp/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightmode,
      home: INTRO(),
    ),
  );
}

class INTRO extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Authgate();
  }
}
