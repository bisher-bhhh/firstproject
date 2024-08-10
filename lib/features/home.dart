import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/UI/widgets/password_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text("Hello"),
          PasswordField(onSaved: (value){}, errorDictionary: [],),

        ],
      )),
    );
  }
}