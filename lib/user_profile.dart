import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/home_page.dart';
import 'package:ecurie_app/login.dart';
import 'package:ecurie_app/register.dart';
import 'package:ecurie_app/create_lesson.dart';
import 'package:ecurie_app/create_show.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    SessionProvider session = Provider.of<SessionProvider>(context);
    String? currentUsername = session.getUser?.getUserName;
    String? currentEmail = session.getUser?.getUserEmail;
    String? currentPhone = session.getUser?.getUserNumber;
    int? currentuserAge = session.getUser?.getUserAge;
    String? currentLink = session.getUser?.getUserLink;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('User Profile'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'User Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Ink.image(
                      image: const AssetImage('assets/images/logo_cheval.jpeg'),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username: $currentUsername',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text('Email: $currentEmail',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          )),
                      Text('Phone: $currentPhone',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          )),
                      Text(
                        'Age: $currentPhone',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        'FFE link: $currentLink',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserProfilePage()),
                                // à changer pour la page d'édition de profil
                              );
                            },
                            child: const Text(
                              'Edit Profile',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateLessonPage()),
                              );
                            },
                            child: const Text('Create Lesson',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateShowPage()),
                              );
                            },
                            child: const Text('Create Show',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'Equitator')),
                );
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
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
