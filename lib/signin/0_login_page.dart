import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:krestakipapp/constants.dart';

import 'package:krestakipapp/signin/1_query_school.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splash.png'), fit: BoxFit.fill),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(height: 100),
          Image(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/logo.png'),
          ),
          SizedBox(
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuerySchool(),
                          fullscreenDialog: true),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.shade100,
                    ),
                    child: Text("Giriş Yap"),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
