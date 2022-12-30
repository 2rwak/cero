import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class editCreditCard extends StatefulWidget {
  const editCreditCard({super.key});

  @override
  State<editCreditCard> createState() => _editCreditCardState();
}

class _editCreditCardState extends State<editCreditCard> {
  final formKeyy = GlobalKey<FormState>();
  bool _obscuretext = true;
  bool _obscuretext2 = true;
  List<int> months = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  int? _selectedMonth = 01;

  var currYear = DateTime.now().year;

  List<int> years = [22, 23, 24, 25, 26, 27, 28, 29];
  int? _selectedYear = 22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141416),
      body: Form(
        key: formKeyy,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Edit Credit card',
                    style: TextStyle(
                      color: Color(0xfff8fafc),
                      fontSize: 26,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(height: 12),
                Container(
                    width: 450,
                    height: 500,
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
            child: SizedBox(
              width: 360,
              height: 50,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
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
            child: SizedBox(
              width: 360,
              height: 50,
              child: TextFormField(
                  obscureText: _obscuretext,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  maxLength: 12,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      counterText: "",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {});
                          _obscuretext = !_obscuretext;
                        },
                        child: Icon(
                          _obscuretext
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
                          borderSide: BorderSide(color: Color(0xFF8A70BE))))),
            ),
          ),
          SizedBox(
            height: 12,
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
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                child: SizedBox(
                  width: 70,
                  height: 55,
                  child: DropdownButtonFormField<int>(
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
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Color(0xFF8A70BE)))),
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
                      onChanged: (item) =>
                          setState(() => _selectedMonth = item)),
                ),
              ),
              Text(
                '/',
                style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 204), fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: SizedBox(
                  width: 75,
                  height: 55,
                  child: DropdownButtonFormField<int>(
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
                  height: 50,
                  child: TextFormField(
                      obscureText: _obscuretext2,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'This field is required';
                      },
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(" "),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
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
            height: 17,
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
            child: SizedBox(
              width: 360,
              height: 50,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
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
                  child: Center(
                    child: Text(
                      'Save',
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
}
