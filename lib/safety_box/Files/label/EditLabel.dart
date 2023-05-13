import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/Files/files.dart';

class EditLabel extends StatefulWidget {
  final String current;
  final String lname;
  final int lcolor;
  final String lid;

  const EditLabel(
      {super.key,
      required this.current,
      required this.lname,
      required this.lcolor,
      required this.lid});

  @override
  State<EditLabel> createState() => _EditLabelState();
}

class _EditLabelState extends State<EditLabel> {
  final formKeyy = GlobalKey<FormState>();
  TextEditingController? _LabelnameController;

  labels _lab = labels(LabelColor: 0);
  int selectedIndex = -1;

  @override
  void initState() {
    _LabelnameController = TextEditingController(text: widget.lname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode cuurentFocus = FocusScope.of(context);
        if (!cuurentFocus.hasPrimaryFocus) {
          cuurentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Color(0xFF141416),
          body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKeyy,
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 30,
                          color: Color(widget.lcolor),
                        ),
                        Text('Edit label\'s title',
                            style: TextStyle(
                              color: Color(0xfff8fafc),
                              fontSize: 26,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                        width: 450,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff1b1b1e),
                        ),
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 32,
                          top: 25,
                          bottom: 10,
                        ),
                        child: _buildQuestionFormL()),
                  ]),
            ),
          )),
    );
  }

  Widget _buildQuestionFormL() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 0.1,
          ),
          Row(
            children: [
              Text(
                '   Label title',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(' *',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFEA0707),
                  ))
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'This field is required';
                  else if (value.length > 10)
                    return "label\'s title should not exceed 10 characters";
                  else
                    return null;
                },
                controller: _LabelnameController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(" "),
                ],
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xFFEA0707),
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xFFEA0707),
                      width: 1.5,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.0, horizontal: 11),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff616161),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF8A70BE))),
                )),
          ),
          SizedBox(
            height: 36,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 41,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF4E5053),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )),
            SizedBox(
              width: 79,
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 41,
                width: 84,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFFEA0707),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  onPressed: () {
                    final isValid = formKeyy.currentState?.validate();
                    if (isValid == true) {
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                content: Text(
                                    'Are you sure you want to delete label\'s title? ',
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
                                        delL();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)))
                                ],
                              ),
                            );
                          });
                    }
                  },
                  child: Center(
                    child: Text(
                      'Delete',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(
              width: 9,
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 41,
                width: 84,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFF8A70BE),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  onPressed: () {
                    final isValid = formKeyy.currentState?.validate();
                    if (isValid == true) {
                      addingL();
                    }
                  },
                  child: Center(
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )),
          ])
        ]);
  }

  void addingL() async {
    setState(() {});

    fireStore_helper.setUID(widget.current);

    _lab.labelName = _LabelnameController!.text;
    _lab.LabelColor = widget.lcolor;
    _lab.labId = widget.lid;

    fireStore_helper.updatelabels(labels(
        labelName: _lab.labelName,
        LabelColor: _lab.LabelColor,
        labId: _lab.labId));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => files(
                  Currentusername: widget.current,
                )));
  }

  void delL() async {
    setState(() {});

    fireStore_helper.setUID(widget.current);

    _lab.labelName = " ";
    _lab.LabelColor = widget.lcolor;
    _lab.labId = widget.lid;

    fireStore_helper.updatelabels(labels(
        labelName: _lab.labelName,
        LabelColor: _lab.LabelColor,
        labId: _lab.labId));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => files(
                  Currentusername: widget.current,
                )));
  }
}
