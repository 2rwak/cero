import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/safety_box/creditCard/addCreditCard.dart';
import 'package:flutter_application_1/safety_box/creditCard/editCreditCard.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import '../../Models/creditCards.dart';

class creditCard extends StatefulWidget {
  final String Currentusername;

  const creditCard({Key? key, required this.Currentusername}) : super(key: key);

  @override
  State<creditCard> createState() => _creditCardState();
}

class _creditCardState extends State<creditCard> {
  void initState() {
    fireStore_helper.setUID(widget.Currentusername);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Color(0xFF8A70BE)),
          backgroundColor: Color(0xFF0F0C07),
          centerTitle: false,
          title: Text(
            'Credit cards',
            style: TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add_outlined,
                color: Color(0xFF8A70BE),
                size: 50,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => addCreditCard(
                              current: widget.Currentusername,
                            )));
              },
            ),
            SizedBox(
              width: 40,
              height: 90,
            )
          ],
        ),
        backgroundColor: Color(0xFF141416),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),

//----------------------------credit card container-------------------------------
              StreamBuilder<List<creditCards>>(
                  stream: fireStore_helper.readCards(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      fireStore_helper.setUID(widget.Currentusername);
                      final Carddata = snapshot.data;
                      return Expanded(
                          child: ListView.builder(
                              itemCount: Carddata!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final singleCard = Carddata[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Container(
                                          width: 360,
                                          height: 232,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Color(0xff1b1b1e),
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                            top: 5,
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .credit_card_outlined,
                                                      color: Color(0xFF8A70BE),
                                                      size: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                        '${singleCard.bankName}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF8A70BE))),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${singleCard.cardNo.toString().substring(0, 4)}   ${singleCard.cardNo.toString().substring(4, 8)}   ${singleCard.cardNo.toString().substring(8, 12)}    ${singleCard.cardNo.toString().substring(12, 16)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 29,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Expiry \n date',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFB7B7B7),
                                                          fontSize: 13),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Text(
                                                        '${singleCard.ExpiryMonth} / ${singleCard.ExpiryYear}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 95),
                                                      child: Text(
                                                        'CVV',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFB7B7B7),
                                                            fontSize: 13),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${singleCard.CVV}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${singleCard.Name}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                      ]),

                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 90,
                                                              right: 0.1),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.edit_outlined,
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              146,
                                                              151),
                                                          size: 32,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => editCreditCard(
                                                                      card: creditCards(
                                                                          bankName: singleCard
                                                                              .bankName,
                                                                          cardNo: singleCard
                                                                              .cardNo,
                                                                          ExpiryMonth: singleCard
                                                                              .ExpiryMonth,
                                                                          ExpiryYear: singleCard
                                                                              .ExpiryYear,
                                                                          CVV: singleCard
                                                                              .CVV,
                                                                          Name: singleCard
                                                                              .Name,
                                                                          cid: singleCard
                                                                              .cid),
                                                                      toEdit: widget
                                                                          .Currentusername)));
                                                        },
                                                      )),
                                                  //delete
                                                  SizedBox(
                                                    width: 0.1,
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.delete_outlined,
                                                        color:
                                                            Color(0xFFEC1F1F),
                                                        size: 32,
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Center(
                                                                child:
                                                                    AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0)),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFF141416),
                                                                  title: Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  content: Text(
                                                                      'Are you sure you want to delete this credit card ? ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16)),
                                                                  actions: [
                                                                    ElevatedButton(
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Color(
                                                                                0xFF4E5053))),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 14))),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(
                                                                            Color(0xFFEC1F1F),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          fireStore_helper
                                                                              .setUID(widget.Currentusername);
                                                                          fireStore_helper
                                                                              .deleteCard(singleCard);

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'Delete',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 14)))
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      })
                                                ]),
                                              ])),
                                    ],
                                  ),
                                );
                              }));
                    }
                    return Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                          "You have no cards yet",
                          style:
                              TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                        ),
                      ],
                    ));
                  })
            ],
          ),
        ));
  }
}
