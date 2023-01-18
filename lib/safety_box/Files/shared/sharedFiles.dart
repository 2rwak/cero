import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class sharedFiles extends StatefulWidget {
  const sharedFiles({super.key});

  @override
  State<sharedFiles> createState() => _sharedFilesState();
}

class _sharedFilesState extends State<sharedFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141416),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
                width: 400,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xff1b1b1e),
                ),
                padding: const EdgeInsets.only(
                    left: 12, right: 1, top: 1, bottom: 1),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 1, left: 8),
                      child: Icon(
                        Icons.insert_drive_file_outlined,
                        color: Color(0xFF8A70BE),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("[NAME]",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(
                      width: 150,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.border_color_outlined,
                          color: Color(0xFF8A70BE),
                          size: 30,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.delete_outlined,
                          color: Color(0xFFEC1F1F),
                          size: 32,
                        ),
                        onPressed: () {
                          dialog();
                        })
                  ],
                )),
          ),
        ],
      ),
    );
  }

//--------------Delete Dialog----------------------
  dialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              backgroundColor: Color(0xFF141416),
              title: Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              content: Text('Are you sure you want to delete this file ? ',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4E5053))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 14))),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFEC1F1F),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Delete',
                        style: TextStyle(color: Colors.white, fontSize: 14)))
              ],
            ),
          );
        });
  }
}
