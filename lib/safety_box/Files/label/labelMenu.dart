import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';

abstract class labelMenu {
  static List<MenuItemss> itemsFirst = [];

  static const List<MenuItemss> itemsSecond = [itemAdd];

  static const itemAdd = MenuItemss(
      text: 'Add label', icon: Icons.add, color: 0xFF8A70BE, lID: "98765466");

  // static const itemSign =
  //     MenuItemss(text: 'Add signature', icon: Icons.add, color: 0);
  // static const List<MenuItemss> item3rd = [itemSign];

  generateLables() {
    List<Color> c = [
      Color(0xFFFF4D4D),
      Color(0xFFFE965C),
      Color(0xFFFFF066),
      Color(0xFF4BF15C),
      Color(0xFF3E67CF)
    ];
  }
}
