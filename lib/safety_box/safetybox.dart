import 'package:flutter/material.dart';
import 'package:flutter_application_1/safety_box/Files/files.dart';
import 'package:flutter_application_1/safety_box/creditCard/creditcard.dart';

class safetybox extends StatefulWidget {
  const safetybox({super.key});

  @override
  State<safetybox> createState() => _safetyboxState();
}

class _safetyboxState extends State<safetybox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0F0C07),
        centerTitle: false,
        title: Text(
          '   Safety box',
          style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => creditCard()));
              },
              child: Container(
                width: 360,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xff1b1b1e),
                ),
                padding: const EdgeInsets.only(
                  left: 1,
                  right: 1,
                  top: 5,
                ),
                child: Row(children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text('Credit card',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A70BE))),
                  Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFF8A70BE),
                      size: 35,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => files()));
              },
              child: Container(
                width: 360,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xff1b1b1e),
                ),
                padding: const EdgeInsets.only(
                  left: 1,
                  right: 1,
                  top: 5,
                ),
                child: Row(children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text('Files',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A70BE))),
                  Padding(
                    padding: const EdgeInsets.only(left: 215),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFF8A70BE),
                        size: 35,
                      ),
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 360,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xff1b1b1e),
              ),
              padding: const EdgeInsets.only(
                left: 1,
                right: 1,
                top: 5,
              ),
              child: Row(children: [
                SizedBox(
                  width: 25,
                ),
                Text('Photos',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8A70BE))),
                Padding(
                  padding: const EdgeInsets.only(left: 190),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFF8A70BE),
                      size: 35,
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
