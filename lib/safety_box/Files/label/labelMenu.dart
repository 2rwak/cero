import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/Models/users.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';

abstract class labelMenu {


  static const List<MenuItemss> itemsFirst = [];

  static const List<MenuItemss> itemsSecond = [itemAdd];

  static const itemAdd =
      MenuItemss(text: 'Add label', icon: Icons.add, color: 0xFF8A70BE);
  
  
  // static const itemSign =
  //     MenuItemss(text: 'Add signature', icon: Icons.add, color: 0);
  // static const List<MenuItemss> item3rd = [itemSign];

  static getlabels() {
    MenuItemss? itemmm;
    StreamBuilder<List<labels>>(
        stream: fireStore_helper.retrieveLabels(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String current = fireStore_helper.getUID();
            fireStore_helper.setUID(current);
            final Ldata = snapshot.data;
            return Expanded(
                child: ListView.builder(
                    itemCount: Ldata!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final singleLabel = Ldata[index];
                      itemmm = MenuItemss(
                          text: singleLabel.labelName!,
                          icon: Icons.circle,
                          color: singleLabel.LabelColor);
                      itemsFirst.add(itemmm!);

                      int color = singleLabel.LabelColor;

                      return Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(color),
                            size: 20,
                          ),
                          Text("${singleLabel.labelName}"),
                        ],
                      );
                    }));
          }
          return Text("nothing");
        });
  }
}
