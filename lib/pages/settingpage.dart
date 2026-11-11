import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(child: Text("Setting")),
    );
  }
}
