import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';

class labelMenu {
  static const List<MenuItemss> itemsFirst = [];

  static const List<MenuItemss> itemsSecond = [itemAdd];
  static const itemAdd = MenuItemss(text: 'Add label', icon: Icons.add);
  static const itemSign = MenuItemss(text: 'Add signature', icon: Icons.add);

  static const List<MenuItemss> item3rd = [itemSign];
  
}
