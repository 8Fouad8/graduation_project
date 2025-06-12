import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/CV/cv_view.dart';
import 'package:graduation_project/views/interview_path_view.dart';
class HubView extends StatelessWidget {
  const HubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hub Page",
          style: Styles.HeaderText(),
        ),
        backgroundColor: Colorize.Theme,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colorize.Theme),
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Welcome, ${user.name}",
            //   style: Styles.HeaderText(),
            // ),
            SizedBox(height: 20),
            Button(text: 'Analyse my CV', navigate: CvView(),spacer: true,),
            SizedBox(height: 20),
            Button(text: 'Make an Interview', navigate: InterviewPathView(),spacer: true,),
          ],
        ),
      ),
    );
  }
}
