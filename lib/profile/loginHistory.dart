import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class loginHistory extends StatefulWidget {
  final String username;
  const loginHistory({super.key, required this.username});

  @override
  State<loginHistory> createState() => _loginHistoryState();
}

class _loginHistoryState extends State<loginHistory> {
  var _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF8A70BE)),
        backgroundColor: Color(0xFF0F0C07),
        centerTitle: false,
        title: Text(
          '   History',
          style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 57,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150, bottom: 10),
            child: Text(
              '  Your login history',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              child: Column(children: [
            SizedBox(
              height: 17,
            ),
            Container(
                width: 360,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xff1b1b1e),
                ),
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 12,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDADADA)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            ' [date here]',
                            style: TextStyle(
                                color: Color(0xFFB7B7B7), fontSize: 13),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Device',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDADADA)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '[device here]',
                            style: TextStyle(
                                color: Color(0xFFB7B7B7), fontSize: 13),
                            textAlign: TextAlign.start,
                          )
                        ]),
                    SizedBox(
                      width: 110,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDADADA)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            ' [time here]',
                            style: TextStyle(
                                color: Color(0xFFB7B7B7), fontSize: 13),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Location',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDADADA)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '[location here]',
                            style: TextStyle(
                                color: Color(0xFFB7B7B7), fontSize: 13),
                            textAlign: TextAlign.start,
                          )
                        ]),
                  ],
                ))
          ]))
        ]),
      ),
    );
  }
}
