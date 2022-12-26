import 'dart:core';

import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(
          authMessages: const [
            IOSAuthMessages(
              cancelButton: 'No thanks',
            )
          ],
          localizedReason: 'Use face ID to authenticate',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ));
    } catch (e) {
      debugPrint('error $e');
      return false;
    }
  }

  bool isUserLoggedIn() {
    // Update as per logged in logic
    return true;
  }

  void logoutUser({String? reason}) {
    // Logout the user
    print('Logged Out: $reason');
  }
}
