import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: IndexedStack(
            index: initialIndex,
            children: [
              indexPage("assets/images/1.png", "Welcome"),
              indexPage("assets/images/2.png", "Application"),
              indexPage("assets/images/3.png", "Press Next to Login"),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            if (initialIndex < 2) {
              initialIndex++;
            } else {
              Navigator.of(context)
                  .pushReplacementNamed("user_details_screens");

              prefs.setBool("isIntroVisited", true);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        child: const Text("Next"),
      ),
    );
  }

  indexPage(String image, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Global.appColor),
        )
      ],
    );
  }
}
