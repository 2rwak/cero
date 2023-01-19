import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/Files/files.dart';
import '../../../navigationBar.dart';

class AddLabel extends StatefulWidget {
  final String current;
  const AddLabel({super.key, required this.current});

  @override
  State<AddLabel> createState() => _AddLabelState();
}

class _AddLabelState extends State<AddLabel> {
  final formKeyy = GlobalKey<FormState>();
  TextEditingController _LabelnameController = TextEditingController();

  labels _lab = labels(LabelColor: 0);
  int selectedIndex = -1;

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
                    Text('Add label',
                        style: TextStyle(
                          color: Color(0xfff8fafc),
                          fontSize: 26,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: 12),
                    Container(
                        width: 450,
                        height: 310,
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
            height: 12,
          ),
          Row(
            children: [
              Text(
                '   Label Color',
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
              child: FormField(
                builder: (FormFieldState<dynamic> field) {
                  return _labelColors();
                },
                validator: (value) {
                  if (selectedIndex == -1 || value == null)
                    return "Please select color";
                  return null;
                },
              )),
          SizedBox(
            height: 36,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: InkWell(
              onTap: () {
                if (_LabelnameController.text.isNotEmpty)
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            backgroundColor: Color(0xFF141416),
                            title: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            content: Text('Are you sure you want to cancel ? ',
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
                                  child: Text('No',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14))),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => navigationBar(
                                                  Currentusername:
                                                      widget.current,
                                                )));
                                  },
                                  child: Text('Yes, cancel',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)))
                            ],
                          ),
                        );
                      });
                else
                  Navigator.pop(context);
              },
              child: Container(
                height: 41,
                width: 94,
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
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(
              width: 80,
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 41,
                width: 94,
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
                    // final isValid = formKeyy.currentState?.validate();
                    // if (isValid == true) {
                    addingL();
                    // }
                  },
                  child: Center(
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ])
        ]);
  }

  List<Color> c = [
    Color(0xFFFF4D4D),
    Color(0xFFFE965C),
    Color(0xFFFFF066),
    Color(0xFF4BF15C),
    Color(0xFF3E67CF)
  ];

  void addingL() async {
    setState(() {});
    _lab.labelName = _LabelnameController.text;
    _lab.LabelColor = c[selectedIndex].value;

    fireStore_helper.setUID(widget.current);

    fireStore_helper.createLabel(labels(
      labelName: _lab.labelName,
      LabelColor: _lab.LabelColor,
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => files(
                  Currentusername: widget.current,
                )));
  }

  _labelColors() {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(5, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            width: 50,
            height: 42,
            margin: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              border: selectedIndex == index
                  ? Border.all(color: Colors.white, width: 3)
                  : Border.all(),
              borderRadius: BorderRadius.circular(5),
              color: c[index],
            ),
          ),
        );
      }),
    );
  }
}
