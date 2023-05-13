import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/safety_box/Invitations/invitaions.dart';
import 'package:flutter_application_1/safety_box/Invitations/invitaions2.dart';
import 'package:flutter_application_1/safety_box/Invitations/invitFiles.dart';

import '../safetybox.dart';

class tabBar extends StatefulWidget {
  final String currentusername;
  const tabBar({super.key, required this.currentusername});

  @override
  State<tabBar> createState() => _tabBarState();
}

class _tabBarState extends State<tabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF8A70BE),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => safetybox(
                              Currentusername: widget.currentusername,
                            )));
              }),
          backgroundColor: Color(0xFF0F0C07),
          centerTitle: false,
          title: Text(
            'Invitations',
            style: TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFF141416),
        body: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            SizedBox(height: 50),
            Container(
              // height: 50,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0xFF0F0C07),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TabBar(
                        unselectedLabelColor: Color(0xFFB7B7B7),
                        labelColor: Colors.white,
                        indicatorColor: Color(0xFF8A70BE),
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                            color: Color(0xFF8A70BE),
                            borderRadius: BorderRadius.circular(15)),
                        controller: _tabController,
                        tabs: [
                          Tab(
                            text: "My files",
                          ),
                          Tab(
                            text: "Invitations",
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  myRequests(Currentusername: widget.currentusername),
                  invitations2(Currentusername: widget.currentusername)
                ],
              ),
            )
          ]),
        )));
  }
}
