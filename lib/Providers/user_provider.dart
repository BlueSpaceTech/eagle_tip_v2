import 'package:testttttt/Services/authentication_helper.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User get getUser => _user!;
  final AuthFunctions _authFunctions = AuthFunctions();
  Future<void> refreshUser() async {
    try {
      User user = await _authFunctions.getUserDetails();
      _user = user;

      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }
}
