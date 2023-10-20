import 'package:ecurie_app/db/class/Users.dart';
import 'package:flutter/foundation.dart';

class SessionProvider extends ChangeNotifier {
  Users? _user;
  Users? _lastSession;

  Users? get getUser => _user;
  Users? get getLastSession => _lastSession;

  void setUser(Users user) {
    _user = user;
    _lastSession = user;
    notifyListeners();
  }

  void loginInSession(){
    _user = _lastSession;
  }

  clearUser() {
    _user = null;
    notifyListeners();
  }
}
