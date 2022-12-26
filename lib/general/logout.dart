import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/general/localAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginPage.dart';

/// Service for handling user auto logout based on user activity
class AutoLogoutService {
  static Timer? _timer;
  static const autoLogoutTimer = 15;
  // Instance of authentication service, prefer singleton
  // final LocalAuth _authService = LocalAuth();
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Resets the existing timer and starts a new timer
  void startNewTimer(context) {
    stopTimer(context);
    _timer = Timer.periodic(const Duration(minutes: autoLogoutTimer), (_) {
      timedOut(context);
    });
  }

  /// Stops the existing timer if it exists
  void stopTimer(context) {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }

  /// Track user activity and reset timer
  // void trackUserActivity([_]) async {
  //   print('User Activity Detected!');
  //   if (_authService.isUserLoggedIn() && _timer != null) {
  //     startNewTimer();
  //   }
  // }

  /// Called if the user is inactive for a period of time and opens a dialog
  Future<void> timedOut(context) async {
    stopTimer(context);

    // Logout the user and pass the reason to the Auth Service
    auth.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
