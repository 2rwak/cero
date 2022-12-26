import 'package:flutter/material.dart';

class docs extends StatefulWidget {
  const docs({super.key});

  @override
  State<docs> createState() => _docsState();
}

class _docsState extends State<docs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141416),
    );
  }
}
