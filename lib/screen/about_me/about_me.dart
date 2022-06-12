import 'package:flutter/material.dart';
import 'package:todo_manabie/view/view.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MinSizeStretchColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Phat Pham',
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "Loving Flutter, Golang, ReactJS",
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  const url = "https://github.com/sideneckx";
                  launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                },
                child: Text("Github"))
          ],
        ),
      ),
    );
  }
}
