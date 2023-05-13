import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile/ViewProfile.dart';
import 'package:flutter_application_1/safety_box/Files/files.dart';
import 'package:flutter_application_1/safety_box/creditCard/creditcard.dart';
import 'package:flutter_application_1/safety_box/safetybox.dart';
import 'package:flutter_application_1/profile/loginHistory.dart';
import 'package:flutter_application_1/wallet/wallet.dart';

class navigationBar extends StatefulWidget {
  final String Currentusername;

  const navigationBar({super.key, required this.Currentusername});

  // :super(key: key);

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Color(0xFF8A70BE),
          inactiveColor: Color(0xFF4E5053), backgroundColor: Color(0xFF0F0C07),

          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.vpn_key_outlined,
                color: Color(0xFF4E5053),
              ),
              activeIcon:
                  Icon(Icons.vpn_key_outlined, color: Color(0xFF8A70BE)),
              label: "Passwords",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_outlined,
                  color: Color(0xFF4E5053),
                ),
                label: "Safety box",
                activeIcon: Icon(
                  Icons.lock_outlined,
                  color: Color(0xFF8A70BE),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.perm_identity,
                  color: Color(0xFF4E5053),
                ),
                activeIcon: Icon(
                  Icons.perm_identity,
                  color: Color(0xFF8A70BE),
                ),
                label: "Profile"),
          ],

          // currentIndex: _selectedIndex,
          // onTap: _onItemTap),
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: wallet(Currentusername: widget.Currentusername),
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Container(
                      child: safetybox(
                    Currentusername: widget.Currentusername,
                  )),
                );
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Container(
                    child: ViewProfile(who: widget.Currentusername),
                  ),
                );
              });
            default:
              CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Container(
                    child: Text("page dates "),
                  ),
                );
              });
          }
          ;
          return Container();
        });
  }
}
