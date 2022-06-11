import 'package:flutter/material.dart';
import 'package:todo_manabie/view/view.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MinSizeStretchColumn(
          children: const [
            Text('Phat Pham'),
            SizedBox(height: 10),
            Text("Flutter, Golang, ReactJS lover"),
          ],
        ),
      ),
    );
  }
}
