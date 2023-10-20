import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/constants.dart';
import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'login.dart';
import 'user_profile.dart';
import 'news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class Events {
  final String name;
  final DateTime? date;

  Events({
    required this.name,
    this.date,
  });

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      name: map['name'],
      date: map['date'],
    );
  }
}

class _NewsPageState extends State<NewsPage> {
  List<Events> eventsList = [];

  Future<void> _affichageUser(MongoDatabase mongoDatabase) async {
    await mongoDatabase.connect();
    final collectionEvent =
        await mongoDatabase.getCollection(EVENTS_COLLECTION);
    final collection = await mongoDatabase.getCollection(USER_COLLECTION);
    final users = await collection.find().toList();
    final events = await collectionEvent.find().toList();

    setState(() {
      eventsList = events.map((event) => Events.fromMap(event)).toList();
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
        title: Text('NEWS'),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
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
              onPressed: () {},
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
