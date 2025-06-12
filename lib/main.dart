import 'package:flutter/material.dart';
import 'package:graduation_project/views/evaluation_interview.dart';
// import 'package:graduation_project/views/home_view.dart';
import 'package:graduation_project/views/hub_view.dart';
// import 'package:graduation_project/views/soft_skills_interview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HubView(),
    );}}