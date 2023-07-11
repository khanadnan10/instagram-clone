import 'package:flutter/material.dart';
import 'package:instagram_clone/database/auth_method.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();

  User? _user;

  User? get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods
        .getUserDetails()
        .catchError((e) => debugPrint(e.toString()));
    _user = user;
    notifyListeners();
  }
}
