import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/users.dart';
import 'package:flutter_application_1/navigationBar.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/profile/ViewProfile.dart';

class editProfile extends StatefulWidget {
  final users user;

  const editProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController? _usernameController;
  TextEditingController? _nationalIDcontroller;
  TextEditingController? _phoneNocontroller;
  TextEditingController? _emailcontroller;

  void initState() {
    _usernameController = TextEditingController(text: widget.user.username);
    _nationalIDcontroller = TextEditingController(text: widget.user.ID);
    _phoneNocontroller = TextEditingController(text: widget.user.phoneNo);
    _emailcontroller = TextEditingController(text: widget.user.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Edit profile',
                  style: TextStyle(
                    color: Color(0xfff8fafc),
                    fontSize: 24,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(height: 12),
              Container(
                width: 450,
                height: 550,
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'UserName',
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
                      Container(
                        width: 350,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xff616161),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'National ID',
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
                      Container(
                        width: 350,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xff616161),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                            controller: _nationalIDcontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Phone number',
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
                      Row(children: [
                        Text(
                          '+966',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          width: 290,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xff616161),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextFormField(
                              controller: _phoneNocontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              )),
                        )
                      ]),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Email',
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
                      Container(
                        width: 350,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xff616161),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                            controller: _emailcontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            )),
                      ),
                      SizedBox(
                        height: 57,
                      ),
                      Row(children: [
                        Center(
                            child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 56,
                            width: 132,
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
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold),
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
                            editpro();
                          },
                          child: Container(
                            height: 56,
                            width: 126,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFF8A70BE),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                      ])
                    ]),
              )
            ]),
      ),
    );
  }

  void editpro() async {
    fireStore_helper.updateProfile(users(
        username: _usernameController!.text,
        ID: _nationalIDcontroller!.text,
        phoneNo: _phoneNocontroller!.text,
        email: _emailcontroller!.text));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => navigationBar(
                  Currentusername: _usernameController!.text,
                 
                )));
  }
}
