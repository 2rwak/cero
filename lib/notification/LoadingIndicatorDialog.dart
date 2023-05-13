import 'package:flutter/material.dart';

class LoadingIndicatorDialog {
  static final LoadingIndicatorDialog _singleton =
      LoadingIndicatorDialog._internal();
  late BuildContext _context;
  bool isDisplayed = false;

  factory LoadingIndicatorDialog() {
    return _singleton;
  }

  LoadingIndicatorDialog._internal();

  show(BuildContext context, {String text = 'Loading...'}) {
    if (isDisplayed) {
      return;
    }
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          _context = context;
          isDisplayed = true;
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF8A70BE),
                  ),
                ),
              ));
        });
  }

  dismiss() {
    if (isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}
