import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/track_view.dart';

class CvView extends StatelessWidget {
  const CvView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("CV Page",  style: Styles.HeaderText(),
        ),
        backgroundColor: Colorize.Theme,),
        
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFF003A3A)),
          width: double.infinity,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Button(text: 'Recommend Track', navigate: TrackView(),spacer: true,),
           ]),
        ));
  }
}
