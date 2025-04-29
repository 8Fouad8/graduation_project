import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/curved_box.dart';
import 'package:graduation_project/models/styles.dart';
// import 'package:graduation_project/views/Auth/login_view.dart';
import 'package:graduation_project/views/Auth/signup_view.dart';
import 'package:graduation_project/views/hub_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colorize.white,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              alignment: Alignment.center,
              child: const Text(
                "here we will put our logo and welcome to our customers",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colorize.Theme),
                maxLines: 2,
              ),
            ),
            const CurvedBox(height: .6,topLeft: true,topRight: true, children: [
              Button(text: 'sign up', navigate: Signup()),
              SizedBox(height: 10),
              Button(text: 'sign in', navigate: HubView()),
            ]),
          ],
        ),
      ),
    );
  }
}
