import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

/// Service for handling user auto logout based on user activity
class AutoLogoutService {
  static Timer? _timer;
  static const autoLogoutTimer = 15;
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
