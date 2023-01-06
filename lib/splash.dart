import 'package:flutter/material.dart';

import 'general/LoginPage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF141416),
        body: Center(
          child: Container(
            child: Column(children: [
              SizedBox(height: 300),
              Image(
                image: AssetImage('assets/mail.png'),
                width: 130,
                height: 130,
              ),
              SizedBox(height: 19),
              Text(
                'Cero | صفر',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Cairo",
                ),
              )
            ]),
          ),
        ));
  }
}
