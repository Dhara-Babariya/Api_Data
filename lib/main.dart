import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fproject/Activities/DisplayNote.dart';
import 'package:fproject/Activities/my_image.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterTodo',
      home:  DisplayNotes(),
    );
  }
}
