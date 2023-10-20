import 'package:ecurie_app/db/class/Users.dart';
import 'package:flutter/foundation.dart';

class SessionProvider extends ChangeNotifier {
  Users? _user;

  Users? get getUser => _user;

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
