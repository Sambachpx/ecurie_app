import 'dart:convert';
import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'background.dart';
import 'db/constants.dart';
import 'register.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _password;

  Future<void> _checkUserInformation(MongoDatabase mongoDatabase) async {
    await mongoDatabase.connect();

    String enteredUsername = _usernameController.text;
    String enteredEmail = _emailController.text;


    final collection = await mongoDatabase.getCollection(USER_COLLECTION);
    print('User: $enteredUsername, Email: $enteredEmail');
    final user = await collection.findOne(mongo.where.eq('username', enteredUsername).eq('email', enteredEmail));
    print('User found: $user');
    if (user != null) {
      String decodedPassword = utf8.decode(base64.decode(user['password']));
      setState(() {
        _password = decodedPassword;
      });
    } else {
      setState(() {
        _password = null;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "FORGOT PASSWORD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            if (_password != null)
              Text(
                "Mot de passe : $_password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  _checkUserInformation(appState.mongoDatabase);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41),
                      ],
                    ),
                  ),
                  child: Text(
                    "RESET PASSWORD",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text(
                "Don't Have an Account? Sign up",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}