import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class Evaluation extends StatelessWidget {
  final int time;

  const Evaluation({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorize.Theme,
        title: Text("Congratulations", style: Styles.HeaderText()),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .18,
            decoration: BoxDecoration(
              color: Colorize.Theme,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                 //   bottomRight: Radius.circular(50)
                 )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name: John Doe\nDate: February 5, 2025\nPosition Applied For: Customer Support \nTime of interview: 8 seconds",
                maxLines: 4,
                style: Styles.HeaderText(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Evaluation Criteria",style: Styles.HeaderLargeText(Colorize.SecondColor),),
              
                Text("1️⃣ Communication Skills (Clarity, Conciseness, Active Listening, Confidence)\n✅ Rating: 4/5\n📝 Comments: John communicated clearly and confidently. He was articulate in his responses and maintained good eye contact. However, he occasionally used filler words when explaining complex ideas.",style: Styles.HeaderText(20,Colorize.SecondColor),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
