import 'package:flutter/material.dart';

import '../../authenticationsection/Models/userModelDietitian.dart';

class UserChatProvider extends ChangeNotifier {
  UserModelDietitian? _userModel;

  void saveUserDetails(UserModelDietitian? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  UserModelDietitian? getUserDetails() => _userModel;
}
