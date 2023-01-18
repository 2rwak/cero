import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Models/creditCards.dart';
import 'package:flutter_application_1/safety_box/creditCard/creditCard.dart';
import 'package:flutter_application_1/safety_box/safetybox.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/safety_box/Files/FirebaseApi.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';

import '../../navigationBar.dart';

class addCreditCard extends StatefulWidget {
  final String current;

  const addCreditCard({super.key, required this.current});

  @override
  State<addCreditCard> createState() => _addCreditCardState();
}

class _addCreditCardState extends State<addCreditCard> {
  TextEditingController _banknameController = TextEditingController();
  TextEditingController _cardnoController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _nameCardController = TextEditingController();
  creditCards _cards = creditCards();

  final formKeyy = GlobalKey<FormState>();
  bool _obscuretext = true;
  bool _obscuretext2 = true;
  List<int> months = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  int? _selectedMonth;

  var currYear = DateTime.now().year;

  List<int> years = [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
  int? _selectedYear;

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
                  Text('Add Credit card',
                      style: TextStyle(
                        color: Color(0xfff8fafc),
                        fontSize: 26,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(height: 12),
                  Container(
                      width: 450,
                      height: 600,
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
                      child: _buildCreditCardForm()),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardForm() {
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
                '   Bank name',
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
                  else if (value.length < 3) {
                    return 'Bank name should be at least 3 characters';
                  }
                },
                controller: _banknameController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny("!"),
                  FilteringTextInputFormatter.deny("?"),
                  FilteringTextInputFormatter.deny("@"),
                  FilteringTextInputFormatter.deny("\$"),
                  FilteringTextInputFormatter.deny("^"),
                  FilteringTextInputFormatter.deny("&"),
                  FilteringTextInputFormatter.deny("*"),
                  FilteringTextInputFormatter.deny("("),
                  FilteringTextInputFormatter.deny(")"),
                  FilteringTextInputFormatter.deny("-"),
                  FilteringTextInputFormatter.deny("_"),
                  FilteringTextInputFormatter.deny("+"),
                  FilteringTextInputFormatter.deny("="),
                  FilteringTextInputFormatter.deny("["),
                  FilteringTextInputFormatter.deny("]"),
                  FilteringTextInputFormatter.deny("{"),
                  FilteringTextInputFormatter.deny("}"),
                  FilteringTextInputFormatter.deny("\\"),
                  FilteringTextInputFormatter.deny("|"),
                  FilteringTextInputFormatter.deny("\'"),
                  FilteringTextInputFormatter.deny("/"),
                  FilteringTextInputFormatter.deny(","),
                  FilteringTextInputFormatter.deny("."),
                  FilteringTextInputFormatter.deny(":"),
                  FilteringTextInputFormatter.deny(";"),
                  FilteringTextInputFormatter.deny("~"),
                  FilteringTextInputFormatter.deny("\""),
                  FilteringTextInputFormatter.deny("%"),
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
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
                '   Card number',
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
                  else if (value.length < 16)
                    return 'Card number should be at least 16 digits';
                  else if (value == '0000000000000000')
                    return 'Invalid card number should not be zeros';
                },
                controller: _cardnoController,
                maxLength: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(" "),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xff616161),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF8A70BE))))),
          ),
          SizedBox(
            height: 19,
          ),
          Row(
            children: [
              Text(
                '   Expiry date',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(' *',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFEA0707),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Text(
                  '   CVV',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Text(' *',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFEA0707),
                  ))
            ],
          ),
          // SizedBox(
          //   height: 3,
          // ),
          Row(
            children: [
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 13, vertical: 1),
              // child:
              SizedBox(
                width: 68,
                height: 40,
                child: DropdownButtonFormField<int>(
                    validator: ((value) {
                      if (value == null) return 'Select \nmonth';
                    }),
                    // menuMaxHeight: 300,
                    dropdownColor: Color(0xFF141416),
                    isExpanded: true,
                    iconSize: 28,
                    menuMaxHeight: 250,
                    decoration: InputDecoration(
                        // disabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        //   borderSide: BorderSide(
                        //     color: Color(0xFFEA0707),
                        //     width: 1.5,
                        //   ),
                        // ),
                        // errorBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        //   borderSide: BorderSide(
                        //     color: Color(0xFFEA0707),
                        //     width: 1.5,
                        //   ),
                        // ),
                        // focusedErrorBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        //   borderSide: BorderSide(
                        //     color: Color(0xFFEA0707),
                        //     width: 1.5,
                        //   ),
                        // ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 1.0, horizontal: 11),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xff616161),
                              width: 1.5,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF8A70BE)))),
                    value: _selectedMonth,
                    items: months
                        .map((item) => DropdownMenuItem<int>(
                              value: item,
                              child: Text(
                                '${item}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) => setState(() => _selectedMonth = item)),
              ),
              //)
              Text(
                ' /',
                style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 204), fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: SizedBox(
                  width: 68,
                  height: 40,
                  child: DropdownButtonFormField<int>(
                      validator: (value) {
                        if (value == null) return "Select \n expiry year";
                      },
                      menuMaxHeight: 250,
                      dropdownColor: Color(0xFF141416),
                      isExpanded: true,
                      iconSize: 28,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xff616161),
                                width: 1.5,
                              )),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Color(0xFF8A70BE)))),
                      value: _selectedYear,
                      items: years
                          .map((item) => DropdownMenuItem<int>(
                                value: item,
                                child: Text(
                                  '${item}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                      onChanged: (item) =>
                          setState(() => _selectedYear = item)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: SizedBox(
                  width: 110,
                  height: 90,
                  child: TextFormField(
                      obscureText: _obscuretext2,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'This field is \nrequired';
                        else if (value.length < 3) {
                          return 'CVV should \ncontain 3 digits';
                        } else if (value == '000')
                          return 'Invalid CVV should \n not be zeros';
                      },
                      controller: _cvvController,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(" "),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 11),
                          counterText: "",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {});
                              _obscuretext2 = !_obscuretext2;
                            },
                            child: Icon(
                              _obscuretext2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff616161),
                              size: 20,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xff616161),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Color(0xFF8A70BE))))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 39,
          ),
          Row(
            children: [
              Text(
                '   Name on credit card',
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
                  else if (value.length < 3) {
                    return 'Name should be at least 3 characters';
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny("!"),
                  FilteringTextInputFormatter.deny("?"),
                  FilteringTextInputFormatter.deny("@"),
                  FilteringTextInputFormatter.deny("\$"),
                  FilteringTextInputFormatter.deny("^"),
                  FilteringTextInputFormatter.deny("&"),
                  FilteringTextInputFormatter.deny("*"),
                  FilteringTextInputFormatter.deny("("),
                  FilteringTextInputFormatter.deny(")"),
                  FilteringTextInputFormatter.deny("-"),
                  FilteringTextInputFormatter.deny("_"),
                  FilteringTextInputFormatter.deny("+"),
                  FilteringTextInputFormatter.deny("="),
                  FilteringTextInputFormatter.deny("["),
                  FilteringTextInputFormatter.deny("]"),
                  FilteringTextInputFormatter.deny("{"),
                  FilteringTextInputFormatter.deny("}"),
                  FilteringTextInputFormatter.deny("\\"),
                  FilteringTextInputFormatter.deny("|"),
                  FilteringTextInputFormatter.deny("\'"),
                  FilteringTextInputFormatter.deny("/"),
                  FilteringTextInputFormatter.deny(","),
                  FilteringTextInputFormatter.deny("."),
                  FilteringTextInputFormatter.deny(":"),
                  FilteringTextInputFormatter.deny(";"),
                  FilteringTextInputFormatter.deny("~"),
                  FilteringTextInputFormatter.deny("\""),
                  FilteringTextInputFormatter.deny("%"),
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
                controller: _nameCardController,
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
                        borderSide: BorderSide(color: Color(0xFF8A70BE))))),
          ),
          SizedBox(
            height: 36,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: InkWell(
              onTap: () {
                if (_banknameController.text.isNotEmpty ||
                    _cardnoController.text.isNotEmpty ||
                    _cvvController.text.isNotEmpty ||
                    _nameCardController.text.isNotEmpty)
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
                            content: Text(
                                'Are you sure you want to cancel adding this credit card ? ',
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
                    final isValid = formKeyy.currentState?.validate();
                    if (isValid == true) {}
                  },
                  child: GestureDetector(
                    onTap: () {
                      final isValid = formKeyy.currentState?.validate();
                      if (isValid == true) {
                        adding2();
                      }
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
              ),
            )),
          ])
        ]);
  }

  void adding2() async {
    setState(() {});
    _cards.bankName = _banknameController.text;
    _cards.cardNo = _cardnoController.text;
    _cards.ExpiryMonth = _selectedMonth;
    _cards.ExpiryYear = _selectedYear;
    _cards.CVV = _cvvController.text;
    _cards.Name = _nameCardController.text;

    print("495: In add credit card widget.current " + widget.current);

    fireStore_helper.setUID(widget.current);
    fireStore_helper.createCards(creditCards(
        bankName: _cards.bankName,
        cardNo: _cards.cardNo,
        ExpiryMonth: _cards.ExpiryMonth,
        ExpiryYear: _cards.ExpiryYear,
        CVV: _cards.CVV,
        Name: _cards.Name,
        cid: _cards.cid));
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('Kbayxiiu2qgCHVFVpMud')
    //     .collection('passwordsswallet')
    //     .add(_pass.toJson());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => creditCard(
                  Currentusername: widget.current,
                )));
  }
}
