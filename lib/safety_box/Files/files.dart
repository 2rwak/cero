import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class files extends StatefulWidget {
  const files({super.key});

  @override
  State<files> createState() => _filesState();
}

class _filesState extends State<files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Color(0xFF8A70BE),),
          backgroundColor: Color(0xFF0F0C07),
          centerTitle: false,
          title: Text(
            'Files',
            style: TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.file_download_outlined,
                color: Color(0xFF8A70BE),
                size: 45,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 40,
              height: 90,
            )
          ],
        ),
        backgroundColor: Color(0xFF141416),
        body: Center(
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 280),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.sort_outlined,
                  color: Color(0xFF8A70BE),
                  size: 40,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 360,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff1b1b1e),
            ),
            padding:
                const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 1, left: 8),
                child: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Color(0xFF8A70BE),
                  size: 30,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text('[file name].[extension]',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ]),
          ),
        ])));
  }
}
