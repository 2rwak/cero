import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/navigationBar.dart';

class pView extends StatefulWidget {
  final String currentusername;
  final String url;
  final String title;
  final String pid;

  const pView(
      {super.key,
      required this.url,
      required this.title,
      required this.pid,
      required this.currentusername});

  @override
  State<pView> createState() => _pViewState();
}

class _pViewState extends State<pView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                leading: BackButton(
                  color: Color(0xFF8A70BE),
                ),
                backgroundColor: Color(0xFF0F0C07),
                centerTitle: true,
                title: Text(
                  '${widget.title.substring(8, 10)}/${widget.title.substring(5, 7)}/${widget.title.substring(0, 4)}\n      ${widget.title.substring(10)}',
                  style: TextStyle(
                      color: Color(0xFFF8FAFC),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Color(0xFFEC1F1F),
                      size: 33,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                backgroundColor: Color(0xFF141416),
                                title: Text(
                                  'Delete photo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                content: Text(
                                    'Are you sure you want to delete this photo ? ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                actions: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xFF4E5053))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color(0xFFEC1F1F),
                                        ),
                                      ),
                                      onPressed: () {
                                        fireStore_helper
                                            .setUID(widget.currentusername);
                                        fireStore_helper.deleteP(widget.pid);

                                        Navigator.of(context).pop();
                                        r();
                                      },
                                      child: Text('Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)))
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  SizedBox(
                    width: 20,
                    height: 90,
                  )
                ]),
            backgroundColor: Color(0xFF0F0C07),
            body: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Center(
                      child: Image.network(
                    widget.url,
                    alignment: Alignment.center,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8A70BE),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )),
                ),
              ],
            )));
  }

  void r() {
    Navigator.of(context).pop();
  }
}
