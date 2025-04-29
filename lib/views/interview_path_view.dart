import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/soft_skills_interview.dart';
import 'package:graduation_project/views/technical_interview.dart';
class InterviewPathView extends StatelessWidget {
  const InterviewPathView ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Interview Page",
          style: Styles.HeaderText(),
        ),
        backgroundColor: Colorize.Theme,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colorize.Theme,),
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(text: 'Technical Interview', navigate: TechnicalInterview(),spacer: true,),
            SizedBox(height: 20),
            Button(text: 'Soft-Skills Interview', navigate: SoftSkillsInterview(),spacer: true,),
          ],
        ),
      ),
    );
  }
}
