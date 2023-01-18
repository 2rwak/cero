import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigationBar.dart';
import 'package:flutter_application_1/general/signUp.dart';
import 'package:flutter_application_1/general/localAuth.dart';
import 'package:flutter_application_1/general/logout.dart';

import 'package:flutter_application_1/email_alert/Location.dart';
import 'package:flutter_application_1/email_alert/time.dart';
import 'package:flutter_application_1/email_alert/device_type.dart';
import 'package:flutter_application_1/email_alert/mailer.dart';
import 'package:flutter_application_1/wallet/wallet.dart';

// import 'package:flutter/fluttertoast/fluttertoast.dart';
import 'LoginPage.dart';

class LoginPageOTP extends StatefulWidget {
  const LoginPageOTP({Key? key}) : super(key: key);
  @override
  State<LoginPageOTP> createState() => _LoginPageOTPState();
}

class _LoginPageOTPState extends State<LoginPageOTP> {
  // get children => null;
  TextEditingController usernameController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";
  String phoneNo = '';
  final Location location_obj = new Location();
  final time time_obj = new time();
  final deviceType device_obj = new deviceType();
  final mailer mail = new mailer();
  final AutoLogoutService _autoLogoutService = AutoLogoutService();

// check if user name is used
  Future getUserPhone(String username) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();

    Map<String, dynamic>? user_data = data.data();
    phoneNo = user_data!['phoneNo'];
    print('phoneNo ' + phoneNo);
    return phoneNo;
  }

  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  signIn() async {
    time_obj.getTime();
    await device_obj.deviceDetails();
    await location_obj.getCurrentLocation();

    await inserting();

    mail.main(usernameController.text);
  }

  Future<void> inserting() async {
    final login_history = <String, String>{
      'Device': device_obj.deviceInfo,
      'Location': location_obj.address,
      'Time': time_obj.time_now,
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(usernameController.text)
        .collection('History')
        .doc('login')
        .set(login_history)
        .onError((e, _) => print("Error writing document: $e"));
  }

  void loginWithPhone() async {
    // CHNAGE here
    String phoneNo = await getUserPhone(usernameController.text);

    auth.verifyPhoneNumber(
      phoneNumber: "+966" + phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () async {
        if (user != null) {
          await signIn();
          _autoLogoutService.startNewTimer(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => wallet(
                        Currentusername: usernameController.text, 
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication failed.'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var userNameController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF141416),
        body: Column(children: [
          SizedBox(height: 160),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/Icon.png'),
                  width: 70,
                  height: 70,
                ),
                Text(
                  "Log in",
                  style: TextStyle(
                    color: Color(0xfff8fafc),
                    fontSize: 36,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ])

          //CONTAINER !!!

          ,
          SizedBox(height: 6),
          Container(
            width: 450,
            height: 360,
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 45,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 0.01),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 370,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff141416),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginPage()));
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff141416),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 52,
                                        right: 51,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Biometric",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xff595961),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xff8a6fbe),
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      // right: 51,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OTP \nOne Time Password",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("    Username",
                      style: TextStyle(
                        color: Color(0xfff8fafc),
                        fontSize: 18,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      )),
                ]),
                SizedBox(height: 10),
                Container(
                  // width: 320,
                  // height: 55,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   border: Border.all(
                  //     color: Color(0xff616161),
                  //     width: 1.5,
                  //   ),
                  // ),
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 16,
                  //   // vertical: 1,
                  // ),
                  // margin: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 320,
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
                          // vertical: 1,
                        ),
                        // margin: EdgeInsets.only(
                        //   bottom: 20,
                        //   top: 20,
                        // ),

                        child: Center(
                          child: TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter your username';
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ' Enter your username',
                                  // prefix: Text('+966 ')

                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Color(0xFF616161))),
                              // maxLength: 10,
                              // keyboardType: TextInputType.phone,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              )),
                        ),
                      ),
                      Visibility(
                        child: TextFormField(
                            controller: otpController,
                            decoration: InputDecoration(
                              hintText: 'OTP',
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Color(0xFF616161)),
                              prefix: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text(''),
                              ),
                            ),
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )),
                        visible: otpVisibility,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        height: 50,
                        minWidth: 273,
                        color: Color(0xFF8A70BE),
                        onPressed: () async {
                          if (otpVisibility) {
                            verifyOTP();
                          } else {
                            bool isUserValid =
                                await usernameCheck(usernameController.text);
                            if (isUserValid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Username does not exist'),
                                ),
                              );
                            } else {
                              loginWithPhone();
                            }
                          }
                        },
                        child: Text(
                          'Log in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Don’t have an account ? ",
                      style: TextStyle(
                        color: Color(0xffd4d4d4),
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => signUp()));
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff8a6fbe),
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
