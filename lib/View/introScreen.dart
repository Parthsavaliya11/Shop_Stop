import 'package:fierbase/Controller/pageViewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class interoScreen extends StatefulWidget {
  const interoScreen({Key? key}) : super(key: key);

  @override
  State<interoScreen> createState() => _interoScreenState();
}

class _interoScreenState extends State<interoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          skip: Text("Skip"),
          showSkipButton: true,
          dotsDecorator: DotsDecorator(activeColor: Colors.lightGreenAccent),
          pages: IntroCont.pageviewcontroller.pagelist,
          showDoneButton: true,
          done: Icon(
            Icons.navigate_next,
            size: 30,
          ),
          onDone: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(duration: Duration(milliseconds: 500),
                content: Text("Please Select One Field"),
              ),
            );
          },
          showNextButton: true,
          next: Icon(
            Icons.arrow_forward,
            size: 30,
          ),
        ),
      ),
    );
  }
}
