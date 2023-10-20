import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'login.dart';
import 'user_profile.dart';
import 'news.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class User {
  final String username;

  User({required this.username});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
    );
  }
}

class _MainPageState extends State<MainPage> {

  List<User> usersList = [];

  Future<void> _affichageUser(MongoDatabase mongoDatabase) async {
    await mongoDatabase.connect();

    final collection = await mongoDatabase.getCollection(USER_COLLECTION);
    final users = await collection.find().toList();

    setState(() {
      usersList = users.map((user) => User.fromMap(user)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _affichageUser(appState.mongoDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenue sur la page principale!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child: Text('Déconnexion'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Un nouvel utilisateur s\'est inscrit : ${usersList[index].username}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.app_registration),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage(title: "test")),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}