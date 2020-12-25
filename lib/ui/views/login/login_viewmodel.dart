import 'package:mynote/ui/views/login/login_view.dart';
import 'package:mynote/ui/views/note/note_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'login_model.dart';

/// Trạng thái của view

class LoginViewModel extends BaseViewModel {
  var username = TextEditingController();
  var password = TextEditingController();
  // Người đăng nhập hiện tại
  static Login userCurrent;

  void handleLogin(context) {
    if (username.text == "admin" && password.text == "password") {
      userCurrent = Login("id", username.text, password.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteView()),
      );
    }
  }
  static void handleLogout(context) {
    userCurrent = null;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
  }
}
